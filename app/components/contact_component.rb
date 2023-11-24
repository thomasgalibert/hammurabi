# frozen_string_literal: true

class ContactComponent < ViewComponent::Base
  def initialize(contact:, dossier:)
    @contact = contact
    @dossier = dossier
  end
end
