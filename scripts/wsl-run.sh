#!/usr/bin/env bash
set -euo pipefail

rootDir="$(cd "$(dirname "$0")/.." && pwd)"
odooDir="$rootDir/src/odoo"

cd "$odooDir"
source .venv/bin/activate
./odoo-bin -c "$rootDir/odoo.conf"
