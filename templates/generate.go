package main

//go:generate go run generate.go

import (
	"bytes"
	"context"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io"
	"math"
	"math/big"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"text/template"
	"time"
)

const (
	publicBlockRPCURL     = "https://sentry.tm.injective.network"
	publicValidatorLCDURL = "https://sentry.lcd.injective.network"
)

type lcdValidatorsResponse struct {
	Validators []lcdValidator `json:"validators"`
	Pagination struct {
		NextKey string `json:"next_key"`
		Total   string `json:"total"`
	} `json:"pagination"`
}

type lcdValidator struct {
	ConsensusPubKey struct {
		Key string `json:"key"`
	} `json:"consensus_pubkey"`
	Description struct {
		Moniker string `json:"moniker"`
	} `json:"description"`
	DelegatorShares string `json:"delegator_shares"`
	Status          string `json:"status"`
}

type validator struct {
	Address string
	Moniker string
	Shares  float64
	Status  string
}

type validatorTemplateData struct {
	Address     string
	DisplayName string
	QueryValue  string
}

type dashboardTemplateData struct {
	Validators     []validatorTemplateData
	ValidatorQuery string
}

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), 45*time.Second)
	defer cancel()

	templatesDir, err := findTemplatesDir()
	if err != nil {
		fatalf("%v", err)
	}

	validators, err := fetchValidators(ctx)
	if err != nil {
		fatalf("fetch validators: %v", err)
	}
	if len(validators) == 0 {
		fatalf("fetch validators: empty validator set")
	}

	templateData := buildValidatorTemplateData(validators)
	dashboardData := dashboardTemplateData{
		Validators:     templateData,
		ValidatorQuery: validatorQuery(templateData),
	}
	for _, dashboard := range []struct {
		source string
		output string
	}{
		{source: "coremon_full.json.tpl", output: "coremon_full.gen.json"},
		{source: "coremon_public.json.tpl", output: "coremon_public.gen.json"},
	} {
		if err := renderDashboardTemplate(
			filepath.Join(templatesDir, dashboard.source),
			filepath.Join(templatesDir, dashboard.output),
			dashboardData,
		); err != nil {
			fatalf("%s: %v", dashboard.source, err)
		}

		fmt.Printf(
			"generated %s with %d validators\n",
			filepath.Join(templatesDir, dashboard.output),
			len(templateData),
		)
	}
}

func findTemplatesDir() (string, error) {
	candidates := []string{
		".",
		"templates",
	}
	for _, candidate := range candidates {
		fullPath, err := filepath.Abs(candidate)
		if err != nil {
			return "", err
		}
		if fileExists(filepath.Join(fullPath, "coremon_full.json.tpl")) &&
			fileExists(filepath.Join(fullPath, "coremon_public.json.tpl")) {
			return fullPath, nil
		}
	}

	return "", fmt.Errorf("could not locate templates directory")
}

func fileExists(path string) bool {
	info, err := os.Stat(path)
	return err == nil && !info.IsDir()
}

func fetchValidators(ctx context.Context) ([]validator, error) {
	client := &http.Client{Timeout: 20 * time.Second}

	var validators []validator
	nextKey := ""
	for {
		endpoint, err := validatorsEndpoint(nextKey)
		if err != nil {
			return nil, err
		}

		var response lcdValidatorsResponse
		if err := getJSON(ctx, client, endpoint, &response); err != nil {
			return nil, err
		}

		for _, item := range response.Validators {
			address, err := pubKeyToAddress(item.ConsensusPubKey.Key)
			if err != nil {
				return nil, fmt.Errorf("validator %q consensus pubkey: %w", item.Description.Moniker, err)
			}

			shares, err := parseDelegatorShares(item.DelegatorShares)
			if err != nil {
				return nil, fmt.Errorf("validator %q delegator shares: %w", item.Description.Moniker, err)
			}

			validators = append(validators, validator{
				Address: address,
				Moniker: item.Description.Moniker,
				Shares:  shares,
				Status:  item.Status,
			})
		}

		if response.Pagination.NextKey == "" {
			break
		}
		nextKey = response.Pagination.NextKey
	}

	sort.SliceStable(validators, func(i, j int) bool {
		leftBonded := validators[i].Status == "BOND_STATUS_BONDED"
		rightBonded := validators[j].Status == "BOND_STATUS_BONDED"
		if leftBonded != rightBonded {
			return leftBonded
		}
		return validators[i].Shares > validators[j].Shares
	})

	return validators, nil
}

func validatorsEndpoint(nextKey string) (string, error) {
	endpoint, err := url.Parse(publicValidatorLCDURL + "/cosmos/staking/v1beta1/validators")
	if err != nil {
		return "", err
	}

	query := endpoint.Query()
	query.Set("pagination.limit", "200")
	if nextKey != "" {
		query.Set("pagination.key", nextKey)
	}
	endpoint.RawQuery = query.Encode()

	return endpoint.String(), nil
}

func getJSON(ctx context.Context, client *http.Client, endpoint string, target any) error {
	request, err := http.NewRequestWithContext(ctx, http.MethodGet, endpoint, nil)
	if err != nil {
		return err
	}

	response, err := client.Do(request)
	if err != nil {
		return err
	}
	defer response.Body.Close()

	if response.StatusCode < http.StatusOK || response.StatusCode >= http.StatusMultipleChoices {
		body, _ := io.ReadAll(io.LimitReader(response.Body, 1024))
		return fmt.Errorf("GET %s: %s: %s", endpoint, response.Status, strings.TrimSpace(string(body)))
	}

	decoder := json.NewDecoder(response.Body)
	if err := decoder.Decode(target); err != nil {
		return fmt.Errorf("decode %s: %w", endpoint, err)
	}

	return nil
}

func pubKeyToAddress(base64PubKey string) (string, error) {
	pubKey, err := base64.StdEncoding.DecodeString(base64PubKey)
	if err != nil {
		return "", err
	}

	sum := sha256.Sum256(pubKey)
	address := strings.ToUpper(hex.EncodeToString(sum[:20]))
	return address, nil
}

func parseDelegatorShares(value string) (float64, error) {
	rat, ok := new(big.Rat).SetString(value)
	if !ok {
		return 0, fmt.Errorf("invalid decimal %q", value)
	}

	scale := new(big.Int).Exp(big.NewInt(10), big.NewInt(18), nil)
	rat.Quo(rat, new(big.Rat).SetInt(scale))

	shares, _ := rat.Float64()
	return math.Round(shares*1e5) / 1e5, nil
}

func buildValidatorTemplateData(validators []validator) []validatorTemplateData {
	data := make([]validatorTemplateData, 0, len(validators))
	for _, item := range validators {
		displayName := fmt.Sprintf("%s (%s)", item.Moniker, formatShares(item.Shares))
		data = append(data, validatorTemplateData{
			Address:     item.Address,
			DisplayName: displayName,
			QueryValue:  fmt.Sprintf("%s : %s", displayName, item.Address),
		})
	}

	return data
}

func formatShares(shares float64) string {
	switch {
	case shares >= 1e9:
		return fmt.Sprintf("%.2fB", shares/1e9)
	case shares >= 1e6:
		return fmt.Sprintf("%.2fM", shares/1e6)
	case shares >= 1e3:
		return fmt.Sprintf("%.2fK", shares/1e3)
	default:
		return fmt.Sprintf("%.2f", shares)
	}
}

func renderDashboardTemplate(sourcePath, outputPath string, data dashboardTemplateData) error {
	tmpl, err := template.New(filepath.Base(sourcePath)).
		Funcs(template.FuncMap{
			"json": jsonTemplateValue,
		}).
		ParseFiles(sourcePath)
	if err != nil {
		return fmt.Errorf("parse template: %w", err)
	}

	var rendered bytes.Buffer
	if err := tmpl.Execute(&rendered, data); err != nil {
		return fmt.Errorf("execute template: %w", err)
	}

	formatted, err := formatJSON(rendered.Bytes())
	if err != nil {
		return err
	}

	if err := os.WriteFile(outputPath, formatted, 0o644); err != nil {
		return err
	}
	if _, err := formatJSONFile(outputPath); err != nil {
		return err
	}

	return nil
}

func jsonTemplateValue(value any) (string, error) {
	rendered, err := json.Marshal(value)
	if err != nil {
		return "", err
	}

	return string(rendered), nil
}

func formatJSON(source []byte) ([]byte, error) {
	var raw json.RawMessage
	if err := json.Unmarshal(source, &raw); err != nil {
		return nil, fmt.Errorf("validate generated JSON: %w", err)
	}

	formatted, err := json.MarshalIndent(raw, "", "  ")
	if err != nil {
		return nil, fmt.Errorf("format generated JSON: %w", err)
	}

	return append(formatted, '\n'), nil
}

func formatJSONFile(path string) ([]byte, error) {
	source, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}

	formatted, err := formatJSON(source)
	if err != nil {
		return nil, err
	}

	return formatted, os.WriteFile(path, formatted, 0o644)
}

func validatorQuery(validators []validatorTemplateData) string {
	values := make([]string, 0, len(validators))
	for _, item := range validators {
		values = append(values, item.QueryValue)
	}

	return strings.Join(values, ", ")
}

func fatalf(format string, args ...any) {
	fmt.Fprintf(os.Stderr, format+"\n", args...)
	os.Exit(1)
}
