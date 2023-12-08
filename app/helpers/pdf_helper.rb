module PdfHelper
  def barcode_input(facture)
		legal_organisation_number = "#{facture.user.firm_setting.business_number.gsub(/\s+/, "")}"
		invoice_number = "#{facture.numero.to_s.gsub(/\s+/, "")}"
		country_code = facture.facture_seal.emetteur_country.upcase.strip
		"#{country_code}-#{legal_organisation_number}-#{invoice_number}"
	end

  def print_address(facture, *args)
		options = args.extract_options!
		size = options[:size] || 9
    seal = facture.facture_seal

		text seal.emetteur_legal_name 
  	text seal.emetteur_address, size: size, color: @gray
    text "#{seal.emetteur_zip_code} #{seal.emetteur_city}, #{seal.emetteur_country.upcase}", size: size, color: @gray
    text "#{at(facture, :emetteur_business_number)} : #{seal.emetteur_business_number}", size: size, color: @gray
    text "#{at(facture, :emetteur_vat_number)} : #{seal.emetteur_vat_number}", size: size, color: @gray
	end

  def print_address_client(facture, *args)
		options = args.extract_options!
		size = options[:size] || 9
    seal = facture.facture_seal

		text seal.client_name 
  	text seal.client_address, size: size, color: @gray
    text "#{seal.client_zip_code} #{seal.client_city}, #{seal.client_country.upcase}", size: size, color: @gray
    text "#{at(facture, :client_business_number)} : #{seal.client_business_number}", size: size, color: @gray
    text "#{at(facture, :client_vat_number)} : #{seal.client_vat_number}", size: size, color: @gray
	end

  def logo(facture)
    if facture.user.facturation_setting.logo.attached?
      url = facture.user.facturation_setting.logo.url
    else
		  url = "https://demerys.s3.amazonaws.com/images/logo_demerys_investment.jpg"
    end
    
		image URI.open(url), position: :right, height: 50
	end

  def row_details(facture)
		[
      [at(facture, :numero), facture.screen_number],
      [at(facture, :currency), facture.currency],
      [at(facture, :date), display_date(facture.date)],
      [at(facture, :due_date), display_date(facture.due_date)],
      [at(facture, :convention_date), facture.convention_number],
      [at(facture, :total_due), number_to_currency(facture.total_ttc)]
    ]		
	end

  def rows(lignes, facture)
    [[
      I18n.t('factures.pdf.lignes.number'),
      I18n.t('factures.pdf.lignes.description'),
      I18n.t('factures.pdf.lignes.quantite'),
      I18n.t('factures.pdf.lignes.prix_unitaire'),
      I18n.t('factures.pdf.lignes.remise'),
      I18n.t('factures.pdf.lignes.total_ht')
    ]] +
    row_items(lignes) +
    [[
      {content: "" }, 
      {content: I18n.t('factures.pdf.lignes.total_ht'), colspan: 4, align: :right }, 
      {content: number_with_precision(facture.total_ht, precision: 2), colspan: 1, align: :right, size: 8 }]] +
    [[
      {content: "" }, 
      {content: I18n.t('factures.pdf.lignes.total_tva'), colspan: 4, align: :right }, 
      {content: number_with_precision(lignes.sum(&:total_tva), precision: 2), colspan: 1, align: :right, size: 8 }]] +

    [[
      {content: "" }, 
      {content: I18n.t('factures.pdf.lignes.total_ttc'), colspan: 4, align: :right }, 
      {content: number_with_precision(facture.total_ttc, precision: 2), colspan: 1, align: :right, size: 8 }]]

  end

  def row_items(lignes)
    data = []

    @lignes.each_with_index do |ligne, index|
      data <<
        [ 
          {content: "1.#{index+1}" },
          {content: ligne.description, size: 8},
          {content: number_with_precision(ligne.quantite, precision: 2), size: 8, align: :center},
          {content: number_with_precision(ligne.prix_unitaire, precision: 2), size: 8},
          {content: number_with_precision(ligne.reduction, precision: 2), size: 8},
          {content: number_with_precision(ligne.total_ht, precision: 2), size: 8}
        ]
    end

    data
  end

  def tax_rows(facture)
    [[
      I18n.t('factures.pdf.lignes.rate'), 
      I18n.t('factures.pdf.lignes.rate_base'), 
      I18n.t('factures.pdf.lignes.total_tva')
    ]] +

    facture.breakdown_tva.map do |rate, value|
      [ number_to_percentage(rate, precision: 2),
        number_with_precision((value[:base]/100), precision: 2),
        number_with_precision((value[:montant]/100), precision: 2),
      ]
    end
  end

  def payment_instructions(facture)
    facturation_setting = facture.user.facturation_setting
    sanitizing(facturation_setting.conditions_paiement.to_s, size: 6)
    move_down 5
  end

  def print_footer(facture)
    facture_seal = facture.facture_seal
    firm_setting = facture.user.firm_setting

    repeat(:all) do
      # Company name and VAT Number
      bounding_box [bounds.left, bounds.bottom + 34], width: bounds.width do
        stroke_horizontal_rule
   
        bounding_box([0, bounds.top-5], width: 575) do
          text "#{facture_seal.emetteur_legal_name} - #{facture_seal.emetteur_address}, #{facture_seal.emetteur_zip_code} - #{facture_seal.emetteur_city}", align: :center, size: 7, color: "6C6C6C"
          text "#{at(facture, :emetteur_vat_number)} : #{facture_seal.emetteur_vat_number} - #{at(facture, :emetteur_business_number)} #{facture_seal.emetteur_business_number}",  align: :center, size: 7, color: "6C6C6C"
          text "#{at(facture, :email)} : #{firm_setting.email} - #{at(facture, :phone_number)} #{firm_setting.phone_number}", size: 7, align: :center, color: "6C6C6C"
        end
        
      end
    end
    # Paging
    string = "<page> / <total>"
    options = { :at => [bounds.right - 150, 7],
                    :width => 150,
                    :align => :right,
                    :size => 7,
                    :start_count_at => 1}
    number_pages string, options
  end

  private

  def display_date(date)
		if date.present?
      I18n.l(date)
    else
      "--"
    end
	end

  def sanitizing(text, *args)
    options = args.extract_options!
    align = options[:align] || :justify
    size = options[:size] || 7
    sanitized_text = sanitize(text, tags: %w(strong em br a), attributes: %w(href))
    formatted_text = sanitized_text.gsub(/<a href=['"]([^'"]+)['"]>(.*?)<\/a>/, '<link target="_blank" href="\1"><color rgb="0000FF">\2</color></link>')
    text formatted_text, inline_format: true, size: size, align: align
  end
end