require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/prawn_outputter'
require "open-uri"
include ActionView::Helpers::SanitizeHelper
include ActionView::Helpers::NumberHelper
include ApplicationHelper
include PdfHelper

class FacturePdf < Prawn::Document
  def initialize(facture)
		# General parameters
		# 595 × 842 points
		# availables 575 x 822 | Mid 280 (15 gutter)
    super(top_margin: 10, bottom_margin: 10, left_margin: 10, right_margin: 10, page_size: "A4")
    self.font_families.update("OpenSans" => {
      :normal => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Regular.ttf"),
      :italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Italic.ttf"),
      :bold => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-Bold.ttf"),
      :bold_italic => Rails.root.join("vendor/assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf")
    })
    font "OpenSans"
    @facture = facture
    @lignes = @facture.lignes
    @delivery_conditions = "-- conditions de livraison --"
    @delivery_address = "-- adress de livraison --"
    @header_width_left = 250
    @header_width_right = 295
    @header_offset = 280
    @gray = "475569"

    # Print differents elements
    print_barcode
    print_kind
    print_sender
    print_logo
    print_details
    print_receiver
    print_reference_dossier(@facture, size: 10)
    print_title
    print_table_items
    print_footer(@facture)
  end

  def print_barcode
  	bounding_box([@header_offset, 822], width: @header_width_right, height: 30) do
      # transparent(0.5) { stroke_bounds }
      barcode = Barby::Code128B.new(barcode_input(@facture) ) 
  		barcode.annotate_pdf(self, xdim: 1)
    end
  end

  def print_kind
  	bounding_box([@header_offset, 782], width: @header_width_right, height: 50) do
      transparent(0.5) { stroke_bounds }
      stroke do
        stroke_color '000000'
        fill_color '000000'
        fill_and_stroke_rounded_rectangle [cursor-50,cursor], @header_width_right, 50, 0
        fill_color '000000'
    	end
    	pad_top(10) { text facture_title(@facture), size: 20, align: :center, color: 'FFFFFF' }
    end
  end

  def print_sender
  	bounding_box([0, 822], width: @header_width_left-60, height: 95) do
      # transparent(0.5) { stroke_bounds }
      text I18n.t('factures.pdf.send_by'), size: 9, color: @gray
      move_down 5
      print_address(@facture)
    end
  end

  def print_logo
  	bounding_box([@header_width_left-70, 822], width: 80) do
  		# transparent(0.5) { stroke_bounds }
  		logo(@facture)
  	end
  end

  def print_receiver
  	bounding_box([@header_offset, 722], width: @header_width_right, height: 110) do
      # transparent(0.5) { stroke_bounds }
      text I18n.t('factures.pdf.sent_to'), size: 9, color: @gray
      move_down 5
      print_address_client(@facture, size: 10)
    end
  end

  def print_details
  	bounding_box([0, 717], width: @header_width_left, height: 120) do
      # transparent(0.5) { stroke_bounds }
      table row_details(@facture), column_widths: [150, 100], cell_style: {border_width: 0.5} do
      	row(0..5).size = 9
        row(0..5).padding = 4
        columns(1).align = :right
        columns(0..1).font = "Courier"
      end
    end
  end

  def print_title
  	move_down 20
  	stroke_horizontal_rule
  	move_down 5
  	text @facture.description.to_plain_text, align: :center, size: 12
  	move_down 5
  	stroke_horizontal_rule
  end

  def print_table_items
    move_down 10
    lignes_counts = @lignes.count+1
    old_y = y
    bounding_box([bounds.left, bounds.top], :width => bounds.width, :height => bounds.height - 30) do
      self.y = old_y
     
      table rows(@lignes, @facture), column_widths: [30, 245, 40, 70, 45, 45, 100], cell_style: {border_width: 0.5} do
        row(0).size = 9
        row(0..lignes_counts).padding = 4
        columns(0..1).size = 8
        columns(2).align = :center
        columns(2..6).font = "Courier"
        columns(3..6).align = :right
        self.row_colors = ["F2F2F2","FFFFFF"]
        self.header = true
      end

      start_new_page if cursor < 121
      print_tax_resume
      print_payment_conditions
    end
  end

  def print_tax_resume
    bounding_box([0, cursor-10], width: @header_width_left, height: 120) do
      # transparent(0.5) { stroke_bounds }
      table tax_rows(@facture), column_widths: [50 , 100 , 100], cell_style: {border_width: 0.5} do
        columns(0..2).align = :right
        columns(0..2).size = 9
        columns(0..2).font = "Courier"
        self.header = true
      end

      move_down 5
      text "Facture acquittée", size: 14, style: :bold, color: "B20202" if @facture.paid?
    end
  end

  def print_payment_conditions
    bounding_box([@header_offset, cursor+120], width: @header_width_right) do
      # transparent(0.5) { stroke_bounds }
      text I18n.t('factures.pdf.payment_conditions')
      move_down 5
      payment_instructions(@facture)
    end
  end

end