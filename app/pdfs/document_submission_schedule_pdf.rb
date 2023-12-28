class DocumentSubmissionSchedulePdf < Prawn::Document
  include PdfHelper

  def initialize(dossier)		
    super(top_margin: 20, bottom_margin: 20, page_size: "A4")

    # Set font family OpenSans
    self.font_families.update("OpenSans" => {
      :normal => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Regular.ttf"),
      :italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Italic.ttf"),
      :bold => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Bold.ttf"),
      :bold_italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf")
    })
    font "OpenSans"

    @dossier = dossier
    @plaintiff = @dossier.contact_principal
    @attorney = @dossier.user
    @firm_setting = @attorney.firm_setting
    @adversary = @dossier.adversary
    @adversary_attorney = @dossier.adversary_attorney

    print_court
    print_title
    print_plaintiff
    print_attorney
    print_adversary
    print_adversary_attorney
    start_new_page
    print_documents_list
    print_number_of_pages
  end

  private

  def print_court
    text @dossier.court, size: 14, style: :bold
    move_down 2
    text "Répertoire général : #{@dossier.rg_number}", size: 12
  end

  def print_title
    move_down 30
    text "Bordereau de pièces communiquées", size: 20, style: :bold, align: :center
    move_down 10
    stroke_horizontal_rule
    move_down 20
  end

  def print_plaintiff
    text "POUR :", size: 16, style: :bold
    move_down 10
    text identity(@plaintiff), size: 12
    move_down 10
  end

  def print_attorney
    text "Ayant pour avocat Maître #{@dossier.user.name.full}", size: 14, style: :bold
    move_down 10
    text attorney_identity, size: 12
    move_down 40
  end

  def print_adversary
    text "CONTRE :", size: 16, style: :bold
    move_down 10
    text identity(@adversary), size: 12
    move_down 10
  end

  def print_adversary_attorney
    text "Ayant pour avocat Maître #{@adversary_attorney.name.full}", size: 14, style: :bold
    move_down 10
    text adversary_attorney_identity, size: 12
    move_down 40
  end

  def print_documents_list
    text "Liste des pièces :", size: 20, style: :bold
    move_down 10
    stroke_horizontal_rule
    move_down 10

    @dossier.documents.each do |document|
      text "#{document.position} - #{document.name}"
    end
  end

  def identity(contact)
    "#{name_or_company(contact)}" +
    ", né le #{contact.birthday_date}" +
    ", excerçant la profession de #{contact.job}" +
    ", et demeurant #{full_address(contact)},"
  end

  def attorney_identity
    "Avocat au barreau de #{@firm_setting.bar_name} \n" +
    "#{full_address_attorney} \n" +
    "Tél. #{@firm_setting.phone_number}     -    Email : #{@firm_setting.email}" +
    mailbox_number(@firm_setting)
  end

  def adversary_attorney_identity
    "Avocat au barreau de #{@adversary_attorney.bar_name} \n" +
    "#{full_address(@adversary_attorney)} \n" +
    "Tél. #{@adversary_attorney.phone}      -    Email #{@adversary_attorney.email}" +
    mailbox_number(@adversary_attorney)
  end

  def full_address(contact)
    "#{contact.address}, #{contact.zip_code} #{contact.city} (#{contact.country})"
  end

  def full_address_attorney
    "#{@firm_setting.address}, #{@firm_setting.zip_code} #{@firm_setting.city} (#{@firm_setting.country})"
  end

  def name_or_company(contact)
    if contact.company_name.present?
      "#{contact.company_name}, représentée par #{contact.name.full}"
    else
      contact.name.full
    end
  end

  def mailbox_number(contact)
    if contact.mailbox_number.present?
      "\n Palais #{contact.mailbox_number}"
    else
      ""
    end
  end
end