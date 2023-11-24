class Convention < ApplicationRecord
  belongs_to :user
  belongs_to :dossier
  has_rich_text :variable

  monetize :forfait_cents
end
