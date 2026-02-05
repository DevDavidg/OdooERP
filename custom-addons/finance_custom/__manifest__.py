{
    "name": "Finance Custom",
    "version": "18.0.1.0.0",
    "category": "Accounting",
    "summary": "Custom finance screens and accounting view tweaks",
    "depends": ["account", "contacts"],
    "data": [
        "security/ir.model.access.csv",
        "views/finance_custom_note_views.xml",
        "views/account_move_inherit.xml",
        "views/menu.xml",
    ],
    "application": False,
    "installable": True,
    "license": "LGPL-3",
}
