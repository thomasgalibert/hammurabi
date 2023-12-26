# frozen_string_literal: true

class ContactShareComponent < ViewComponent::Base
  with_collection_parameter :contact
  
  def initialize(contact:, dossier:)
    @contact = contact
    @dossier = dossier
  end
end
