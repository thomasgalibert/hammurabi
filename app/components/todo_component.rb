# frozen_string_literal: true

class TodoComponent < ViewComponent::Base
  def initialize(todo:, can_edit:, show_dossier:)
    @todo = todo
    @can_edit = can_edit
    @show_dossier = show_dossier
  end

end
