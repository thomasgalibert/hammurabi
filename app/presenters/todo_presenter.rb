class TodoPresenter < Keynote::Presenter
  presents :todo

  def name
    content_tag :span, todo.name, class: "text-xs font-medium line-clamp-1"
  end

  def dossier
    content_tag :span, todo.todoable.name, class: "font-semibold text-stone-600"
  end

  def created_at
    I18n.l(todo.created_at, format: :short)
  end

  def due_at
    if todo.due_at.present?
      I18n.l(todo.due_at, format: :short)
    end
  end

  def url
    url_for(todo.todoable)
  end
end