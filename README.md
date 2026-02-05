# OdooERP

Odoo 18 con módulo custom `finance_custom`.

## Requisitos

- WSL2 (Ubuntu recomendado) o Linux
- Git
- Python 3.12+
- PostgreSQL
- Node.js 20 (para rtlcss)

## Instalación desde cero

### 1. Clonar

```bash
git clone <url-repo> OdooERP
cd OdooERP
```

### 2. Ejecutar script de instalación

```bash
chmod +x scripts/wsl-install.sh
./scripts/wsl-install.sh
```

Instala: Python, PostgreSQL, Node.js, clona Odoo 18, crea venv, instala dependencias y base de datos `odoo18_finance`.

### 3. Configurar `odoo.conf`

Las rutas en `odoo.conf` son relativas al directorio del proyecto. Si ejecutas desde otra ruta, ajusta `data_dir` y `addons_path` si hace falta.

### 4. Iniciar Odoo

```bash
./scripts/wsl-run.sh
```

Abre http://localhost:8069

### 5. Crear base de datos (primera vez)

En http://localhost:8069/web/database/manager crea una base nueva o usa `odoo18_finance` si ya existe.

### 6. Instalar módulos

En la base de datos: **Apps** → buscar "Finance Custom" → **Install**.

O vía CLI (cuenta + módulos base):

```bash
cd src/odoo && source .venv/bin/activate
./odoo-bin -c ../../odoo.conf -d odoo18_finance -i account,contacts --stop-after-init
./odoo-bin -c ../../odoo.conf -d odoo18_finance -i finance_custom --stop-after-init
```

## Estructura

```
OdooERP/
├── custom-addons/
│   └── finance_custom/
├── data/
├── scripts/
│   ├── wsl-install.sh
│   ├── wsl-install-account-and-addon.sh
│   └── wsl-run.sh
├── src/odoo/
└── odoo.conf
```

## Credenciales DB (por defecto)

- User: `odoo`
- Password: `odoo`
- Database: `odoo18_finance`
