class EventPresenter < Keynote::Presenter
  presents :event

  def badge
    wrapper_class = "h-8 w-8 rounded-full text-white bg-stone-400 flex items-center justify-center ring-8 ring-white"
    svg_class = "h-5 w-5"

    content_tag :span, class: wrapper_class do
      content_tag :i, class: "{svg_class} #{set_icon(event)}" do
      end
    end
  end

  def set_icon(event)
    case event.kind
    when "meeting" then meeting_icon
    when "signature" then signature_icon
    when "hearing" then hearing_icon
    when "conciliation_hearing" then conciliation_hearing_icon
    when "judgment_hearing" then judgment_hearing_icon
    when "expertise" then expertise_icon
    else unknow_icon
    end
  end

  def meeting_icon = "fa-solid fa-handshake"
  def signature_icon = "fa-solid fa-signature"
  def hearing_icon = "fa-solid fa-gavel"
  def conciliation_hearing_icon = "fa-solid fa-gavel"
  def judgment_hearing_icon = "fa-solid fa-gavel"
  def expertise_icon = "fa-solid fa-helmet-safety"
  def unknow_icon = "fa-sharp fa-solid fa-calendar"


end