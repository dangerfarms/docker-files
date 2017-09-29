#!/usr/bin/env bash
# Helper function to create kubernetes secret
set -e

key_json_b64=$(base64 "$1" -w 0)
cp secret-template.yaml secret.yaml
echo -n " $key_json_b64" >> secret.yaml

echo "Secret is saved to (the ignored file) secret.yaml"
