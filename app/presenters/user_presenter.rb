class UserPresenter < Keynote::Presenter
  presents :user

  def email_signature
    user.firm_setting.legal_name + " \n" +
    user.firm_setting.address + "\n" +
    user.firm_setting.zip_code + " " + user.firm_setting.city + "\n" +
    user.firm_setting.phone_number + "\n" + user.firm_setting.email
  end

  def accountant_share_link
    path = sharing_invoices_url(token: user.accountant_share_token)
    input_class = "border rounded px-2 py-1 w-full border-stone-300 text-sky-600"
    
    content_tag :input, "", type: :text, disabled: true, class: input_class, value: path
  end
end