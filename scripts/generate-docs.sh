#!/usr/bin/env bash
set -euo pipefail
pushd modules/vnet >/dev/null
terraform-docs .
popd >/dev/null
terraform-docs .
