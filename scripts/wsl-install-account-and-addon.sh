#!/usr/bin/env bash
set -euo pipefail

rootDir="$(cd "$(dirname "$0")/.." && pwd)"
odooDir="$rootDir/src/odoo"
dbName="${1:-odoo18_finance}"

cd "$odooDir"
source .venv/bin/activate
./odoo-bin -c "$rootDir/odoo.conf" -d "$dbName" -i account -u finance_custom --stop-after-init
