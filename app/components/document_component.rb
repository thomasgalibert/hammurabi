# frozen_string_literal: true

class DocumentComponent < ViewComponent::Base
  def initialize(document:, show_dossier:, current_user: nil)
    @document = document
    @show_dossier = show_dossier
    @current_user = current_user
  end

end
