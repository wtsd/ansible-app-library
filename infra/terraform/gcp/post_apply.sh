#!/usr/bin/env bash
set -euo pipefail
terraform output -raw generated_inventory > generated_inventory.ini
echo "[INFO] Wrote inventory to $(pwd)/generated_inventory.ini"
