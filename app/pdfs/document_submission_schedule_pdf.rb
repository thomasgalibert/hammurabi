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
    print_documents_list
    print_number_of_pages
  end

  private

  def print_documents_list
    text "Liste des pièces :", size: 20, style: :bold
    move_down 10
    stroke_horizontal_rule
    move_down 10

    @dossier.documents.each do |document|
      text "#{document.position} - #{document.name}"
    end
  end
end