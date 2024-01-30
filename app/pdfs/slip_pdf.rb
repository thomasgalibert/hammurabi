class SlipPdf < Prawn::Document
  include PdfHelper

  def initialize(slip)		
    super(top_margin: 20, bottom_margin: 20, page_size: "A4")

    # Set font family OpenSans
    self.font_families.update("OpenSans" => {
      :normal => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Regular.ttf"),
      :italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Italic.ttf"),
      :bold => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Bold.ttf"),
      :bold_italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf")
    })
    font "OpenSans"

    @slip = slip
    @dossier = @slip.dossier
    @plaintiff = @dossier.contact_principal
    @attorney = @dossier.user
    @firm_setting = @attorney.firm_setting
    @adversary = @dossier.adversary
    @adversary_attorney = @dossier.adversary_attorney

    print_attorney
    print_court
    print_title
    print_plaintiff
    print_adversary
    print_previous_list if @slip.number > 1
    print_documents_list
    print_date
    print_number_of_pages
  end

  private

  def print_court
    text "Affaire #{@dossier.name}", size: 14, style: :bold
    text @slip.recipient, size: 12
    move_down 2
    text "RG : #{@dossier.rg_number}", size: 12
  end

  def print_title
    move_down 30
    text "Bordereau de communication de pièces #{@slip.full_number}", size: 20, style: :bold, align: :center
    move_down 10
    stroke_horizontal_rule
    move_down 20
  end

  def print_plaintiff
    text "Pièces communiquées par Maître #{@attorney.first_name} #{@attorney.last_name}, avocat de #{name_or_company(@plaintiff)},", size: 12
    move_down 10
  end

  def print_attorney
    text "#{@dossier.user.name.full}", size: 12, style: :bold, align: :center
    move_down 5
    text attorney_identity, size: 10, align: :center
    move_down 20
  end

  def print_adversary
    text "A", size: 14
    move_down 10
    text "Maître #{@adversary_attorney.first_name} #{@adversary_attorney.last_name}, avocat de #{name_or_company(@adversary)}.", size: 12
    move_down 10
  end

  def print_adversary_attorney
    text "Ayant pour avocat Maître #{@adversary_attorney.name.full}", size: 14, style: :bold
    move_down 10
    text adversary_attorney_identity, size: 12
    move_down 40
  end

  def print_documents_list
    move_down 20
    text "#{title_list(@slip)} communiquées :", size: 14, style: :bold
    move_down 10
    stroke_horizontal_rule
    move_down 10

    @slip.documents.each do |document|
      text "#{document.position} - #{document.name}"
    end
  end

  def print_previous_list
    move_down 20
    text "Pièces déjà communiquées :", size: 14, style: :bold
    move_down 10
    stroke_horizontal_rule
    move_down 10

    @slip.previous_slips.each do |slip|
      text "Bordereau #{slip.full_number} du #{I18n.l(slip.date, format: :long)} :", size: 12, style: :bold
      move_down 10

      slip.documents.each do |document|
        text "#{document.position} - #{document.name}"
      end
    end
  end

  def print_date
    move_down 20
    text "À #{@attorney.firm_setting.city}, le #{I18n.l(@slip.date, format: :long)}"
  end

  private

  def attorney_identity
    "Avocat au barreau de #{@firm_setting.bar_name} \n" +
    (@firm_setting.honorific_titles.empty? ? "" : "#{@firm_setting.honorific_titles} \n") +
    "#{full_address_attorney} \n" +
    "Tél. #{@firm_setting.phone_number} - Email : #{@firm_setting.email}"
  end

  def full_address(contact)
    "#{contact.address}, #{contact.zip_code} #{contact.city} (#{contact.country})"
  end

  def full_address_attorney
    "#{@firm_setting.address}, #{@firm_setting.zip_code} #{@firm_setting.city} (#{@firm_setting.country})"
  end

  def name_or_company(contact)
    if contact.company_name.present?
      "#{contact.company_name}"
    else
      contact.name.full
    end
  end
end