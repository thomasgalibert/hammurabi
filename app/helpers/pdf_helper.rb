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
      ["Numéro", facture.screen_number],
      ["Devise", facture.currency],
      ["Date", display_date(facture.date)],
      ["Date d'exigibilité", display_date(facture.due_date)],
      ["Réf commande", facture.dossier.convention_number],
      ["NET à payer", "facture.total_ttc"]
    ]		
	end

  private

  def display_date(date)
		if date.present?
      I18n.l(date)
    else
      "--"
    end
	end
end