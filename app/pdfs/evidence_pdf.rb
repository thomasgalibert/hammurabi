class EvidencePdf < Prawn::Document
  require "open-uri"

  def initialize(number)
    super(top_margin: 20, bottom_margin: 20, page_size: "A4")
    self.font_families.update("OpenSans" => {
      :normal => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Regular.ttf"),
      :italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Italic.ttf"),
      :bold => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Bold.ttf"),
      :bold_italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf")
    })
    font "OpenSans"
    @number_string = number.to_s
    stamp
  end

  def stamp
    bounding_box([470, bounds.top-50], width: 100, height: 50) do
      # transparent(0.5) { stroke_bounds }
      # Draw a red circle with the number inside

      stroke_color "FF0000"
      stroke_ellipse [bounds.left+bounds.width/2, bounds.top-bounds.height/2], 30, 30
      # stroke_color "000000"

      bounding_box([-65, bounds.top-10], width: 230) do
        text "Pièce N°", size: 10, align: :center, color: "FF0000"
        text @number_string, size: 14, align: :center, color: "FF0000", style: :bold
      end
    end
  end

end