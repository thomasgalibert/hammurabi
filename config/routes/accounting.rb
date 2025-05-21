scope "accounting" do
  get "monthly_reports", to: "accounting/reports#monthly_reports", as: :accounting_monthly_reports
  get "invoice_details", to: "accounting/reports#invoice_details", as: :accounting_invoice_details
  get "payment_details", to: "accounting/reports#payment_details", as: :accounting_payment_details
  get "unpaid_invoices", to: "accounting/reports#unpaid_invoices", as: :accounting_unpaid_invoices
end