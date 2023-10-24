class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :kind
      t.string :last_name
      t.string :first_name
      t.string :company_name
      t.string :business_number
      t.string :vat_number
      t.string :email
      t.string :phone
      t.text :address
      t.string :zip_code
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
