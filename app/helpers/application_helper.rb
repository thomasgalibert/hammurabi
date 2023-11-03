module ApplicationHelper
  def class_badge(state)
    case state
      when 'pending' then "bg-yellow-50 text-yellow-700 ring-yellow-600/20"
      when 'archived' then "bg-gray-50 text-gray-700 ring-gray-600/20"
      when 'sent' then "bg-blue-50 text-blue-700 ring-blue-600/20"
      when 'paid' then "bg-emerald-50 text-emerald-700 ring-emerald-600/20"
      when 'overdue' then "bg-red-50 text-red-700 ring-red-600/20"
    else "bg-gray-50 text-gray-700 ring-gray-600/20"
    end
  end
end
