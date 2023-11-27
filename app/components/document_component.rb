# frozen_string_literal: true

class DocumentComponent < ViewComponent::Base
  def initialize(document:, show_dossier:)
    @document = document
    @show_dossier = show_dossier
  end

end
