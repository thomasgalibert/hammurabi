# app/helpers/custom_form_builder.rb

class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(method, options = {})
    label_content = label(method, class: label_class)
    field_content = super(method, merge_tailwind_classes(input_class, options))

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  def date_field(method, options = {})
    label_content = label(method, class: label_class)
    field_content = super(method, merge_tailwind_classes(input_class, options))

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  def email_field(method, options = {})
    label_content = label(method, class: label_class)
    field_content = super(method, merge_tailwind_classes(input_class, options))

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  def phone_field(method, options = {})
    label_content = label(method, class: label_class)
    field_content = super(method, merge_tailwind_classes(input_class, options))

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  # Ajoutez d'autres méthodes de champs ici...
  def password_field(method, options = {})

    label_content = label(method, class: label_class)
    field_content = super(method, merge_tailwind_classes(input_class, options))

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  def submit(value = nil, options = {})
    options.merge!(class: "inline-flex w-full justify-center py-2 px-4 border border-transparent shadow-sm text-lg rounded-md font-medium text-white bg-emerald-500 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-600")

    @template.content_tag(:div, class: "flex justify-end mt-6") do
      super(value, options)
    end
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    label_content = label(method, class: [label_class, "ml-2"])
    field_content = super(method, options, checked_value, unchecked_value)

    @template.content_tag(:div, class: field_class) do
      @template.content_tag(:div, field_content + label_content, class: "flex items-center")
    end
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    label_content = label(method, class: label_class)
    field_content = super(method, choices, options, merge_tailwind_classes(select_class, html_options), &block)

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})

    label_content = label(method, class: label_class)
    field_content = super(method, collection, value_method, text_method, options, html_options)

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  def country_select(method, priority_countries = nil, options = {}, html_options = {})
    label_content = label(method, class: label_class)
    field_content = super(method, ["FR","ES","DE"], {sort_provided: false}, merge_tailwind_classes(select_class, html_options))

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  def text_area(method, options = {})
    label_content = label(method, class: label_class)
    field_content = super(method, merge_tailwind_classes(input_class, options))

    @template.content_tag(:div, class: field_class) do
      label_content + @template.content_tag(:div, field_content, class: "mt-2")
    end
  end

  private

  def merge_tailwind_classes(default_class, options)
    class_name = options[:class]
    options.merge(class: class_name ? "#{default_class} #{class_name}" : default_class)
  end

  def label_class
    "block text-sm font-medium text-gray-500"
  end

  def input_class
    "mt-1 rounded-md focus:ring-gray-800 focus:border-gray-800 block w-full shadow-sm sm:text-sm border-gray-500"
  end

  def field_class
    "mb-6"
  end

  def select_class
    "mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-500 focus:ring-2 focus:ring-emerald-600 sm:text-sm sm:leading-6"
  end
end
