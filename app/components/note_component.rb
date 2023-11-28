# frozen_string_literal: true

class NoteComponent < ViewComponent::Base
  def initialize(note:)
    @note = note
  end

end
