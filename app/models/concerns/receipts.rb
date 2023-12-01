module Receipts
  extend ActiveSupport::Concern

  included do
    before_save :update_payment_status
  end

  def update_payment_status
    if payments.empty?
      self.payment_status = "unpaid"
    elsif total_ttc_cents == payments.sum(&:amount_cents)
      self.payment_status = "paid"
    elsif total_ttc_cents > payments.sum(&:amount_cents)
      self.payment_status = "partial"
    else
      self.payment_status = "unpaid"
    end
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