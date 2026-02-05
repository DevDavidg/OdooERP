#!/usr/bin/env bash
set -euo pipefail

rootDir="$(cd "$(dirname "$0")/.." && pwd)"
odooDir="$rootDir/src/odoo"
odooVersion="18.0"
dbName="odoo18_finance"
dbUser="odoo"
dbPassword="odoo"

sudo apt update
sudo apt install -y git build-essential python3 python3-venv python3-dev python3-pip \
  libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libjpeg-dev libpq-dev \
  libffi-dev libssl-dev zlib1g-dev liblcms2-dev libopenjp2-7-dev libtiff-dev \
  libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev postgresql postgresql-contrib curl

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g rtlcss

sudo service postgresql start

if ! sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='${dbUser}'" | grep -q 1; then
  sudo -u postgres createuser -s "${dbUser}"
fi
sudo -u postgres psql -c "ALTER USER ${dbUser} PASSWORD '${dbPassword}';"

if ! sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='${dbName}'" | grep -q 1; then
  sudo -u postgres createdb -O "${dbUser}" "${dbName}"
fi

mkdir -p "$rootDir/src" "$rootDir/custom-addons" "$rootDir/data"

if [ ! -d "$odooDir/.git" ]; then
  git clone --depth 1 --branch "${odooVersion}" https://github.com/odoo/odoo.git "$odooDir"
fi

cd "$odooDir"
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip wheel
pip install -r requirements.txt

echo "OK"
