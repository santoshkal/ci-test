package main

import (
	"fmt"
	"strings"

	"github.com/google/go-containerregistry/pkg/name"
)

func main() {
	url1 := "oci://ghcr.io/santoshkal/ci-test/test:v0.0.1"
	ociURL, ref, err := parseURL(url1)
	if err != nil {
		fmt.Printf("Error parsing url: %v", err)
	}
	fmt.Printf("Parsed URL: %v", ociURL)

	fmt.Printf("REF URL: %v", ref)
}

func parseURL(s string) (string, name.Reference, error) {
	if !strings.HasPrefix(s, "oci://") {
		return "", nil, fmt.Errorf("URL must be in format 'oci://<domain>/<org>/<repo>'")
	}

	trimmedURL := strings.TrimPrefix(s, "oci://")
	ref, err := name.ParseReference(trimmedURL)
	if err != nil {
		fmt.Printf("Error oarsing oci: %v", err)
	}

	return trimmedURL, ref, nil
}
