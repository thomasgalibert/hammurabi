# frozen_string_literal: true

class TodoComponent < ViewComponent::Base
  def initialize(todo:)
    @todo = todo
  end

end
