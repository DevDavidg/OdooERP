#!/usr/bin/env bash
set -euo pipefail

rootDir="$(cd "$(dirname "$0")/.." && pwd)"
odooDir="$rootDir/src/odoo"

cd "$rootDir"
source "$odooDir/.venv/bin/activate"
"$odooDir/odoo-bin" -c "$rootDir/odoo.conf"
