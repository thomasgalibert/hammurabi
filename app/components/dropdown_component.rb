# frozen_string_literal: true

class DropdownComponent < ViewComponent::Base
  erb_template <<-ERB
    <div class="relative inline-block text-left" data-controller="dropdown" data-action="dropdown:click:outside->dropdown#close" >
      <div>
        <button data-action="click->dropdown#toggle" type="button" class="flex items-center rounded-full bg-gray-100 text-gray-400 hover:text-gray-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-100" id="menu-button" aria-expanded="true" aria-haspopup="true">
          <span class="sr-only">Open options</span>
          <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path d="M10 3a1.5 1.5 0 110 3 1.5 1.5 0 010-3zM10 8.5a1.5 1.5 0 110 3 1.5 1.5 0 010-3zM11.5 15.5a1.5 1.5 0 10-3 0 1.5 1.5 0 003 0z" />
          </svg>
        </button>
      </div>

      <div data-dropdown-target="menu" class="absolute hidden right-0 z-10 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button" tabindex="-1">
        <div class="py-1" role="none">
          <%= link_to t('todos.buttons.edit'), polymorphic_url([:edit, @todo.todoable, @todo]), class: "text-gray-700 block px-4 py-2 text-sm" %>
        </div>
      </div>
    </div>
  ERB

  def initialize(todo:)
    @todo = todo
  end
end
