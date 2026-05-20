#!/bin/bash

# Build custom ERPNext image with HRMS for ARM64 (Apple Silicon)
# This script builds a custom Docker image that includes both ERPNext and HRMS apps

echo "Building custom ERPNext + HRMS + ERPNext Thailand image for ARM64..."

# Encode apps.json to base64
export APPS_JSON_BASE64=$(base64 -i apps.json)

# Build the custom image for ARM64 architecture
docker build \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=PYTHON_VERSION=3.11.9 \
  --build-arg=NODE_VERSION=20.19.2 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --platform=linux/arm64 \
  --tag=custom-erpnext-thailand:v15 \
  --file=images/layered/Containerfile .

echo ""
echo "✅ Build complete! Image tagged as: custom-erpnext-thailand:v15"
echo ""
echo "Next steps:"
echo "1. Run: docker compose -f pwd.yml up -d"
echo "2. Monitor installation: docker compose -f pwd.yml logs -f create-site"
echo "3. Access ERPNext at: http://localhost:8080 (username: Administrator, password: admin)"
