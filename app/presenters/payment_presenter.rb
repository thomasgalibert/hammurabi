class PaymentPresenter < Keynote::Presenter
  presents :payment

  def amount_with_date
    "#{payment.amount} € le #{I18n.l(payment.issued_date, format: :short)}"
  end
end
