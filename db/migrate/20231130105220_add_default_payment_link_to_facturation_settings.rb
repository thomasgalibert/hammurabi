class AddDefaultPaymentLinkToFacturationSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :facturation_settings, :default_payment_link, :string
  end
end
