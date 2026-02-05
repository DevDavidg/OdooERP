from odoo import fields, models


class FinanceCustomNote(models.Model):
    _name = "finance.custom.note"
    _description = "Finance Custom Note"
    _order = "date desc, id desc"

    name = fields.Char(required=True)
    note = fields.Text()
    partner_id = fields.Many2one("res.partner", ondelete="set null")
    amount = fields.Float()
    date = fields.Date(default=fields.Date.context_today)


class ResPartner(models.Model):
    _inherit = "res.partner"

    finance_custom_note_ids = fields.One2many("finance.custom.note", "partner_id")
    finance_custom_note_count = fields.Integer(compute="_compute_finance_custom_note_count")

    def _compute_finance_custom_note_count(self):
        counts = {}
        if self.ids:
            grouped = self.env["finance.custom.note"].read_group(
                [("partner_id", "in", self.ids)],
                ["partner_id"],
                ["partner_id"],
            )
            counts = {g["partner_id"][0]: g["partner_id_count"] for g in grouped if g.get("partner_id")}
        for partner in self:
            partner.finance_custom_note_count = counts.get(partner.id, 0)

    def actionViewFinanceCustomNotes(self):
        self.ensure_one()
        action = self.env.ref("finance_custom.action_finance_custom_note").read()[0]
        action["domain"] = [("partner_id", "=", self.id)]
        action["context"] = dict(self.env.context, default_partner_id=self.id)
        return action


class AccountMove(models.Model):
    _inherit = "account.move"

    finance_custom_ref = fields.Char(copy=False)
