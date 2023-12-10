module Receipts
  extend ActiveSupport::Concern

  included do
    after_save :update_payment_status
  end

  def update_payment_status
    if self.payments.empty?
      new_status = "unpaid"
    elsif total_ttc_cents == payments.sum(&:amount_cents)
      new_status = "paid"
    elsif total_ttc_cents > payments.sum(&:amount_cents)
      new_status = "partial"
    else
      new_status = "unpaid"
    end

    self.update(payment_status: new_status) if self.payment_status != new_status
  end

  def paid?
    payment_status == "paid"
  end

  def unpaid?
    payment_status == "unpaid"
  end

  def partial?
    payment_status == "partial"
  end

end