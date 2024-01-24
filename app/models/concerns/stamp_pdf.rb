module StampPdf
  extend ActiveSupport::Concern

  def stamped
    all_pages  = CombinePDF.new
    document_content = CombinePDF.parse Net::HTTP.get_response(URI.parse(self.fichier.url)).body
    document_content = put_evidence_stamp(document_content, self.position, self.user.firm)
    all_pages << document_content
    all_pages
  end

  private

  def put_evidence_stamp(document_content, number, firm)
    evidence_pdf_data = EvidencePdf.new(number, firm).render
    evidence_pdf = CombinePDF.parse(evidence_pdf_data)

    document_content.pages[0] << evidence_pdf.pages[0]
    document_content
  end

end