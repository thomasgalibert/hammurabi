class Payment < ApplicationRecord
  belongs_to :facture
  belongs_to :user

  after_create :update_facture
  after_destroy :update_facture

  private

  def update_facture
    facture.save
  end
end
