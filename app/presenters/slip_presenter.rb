class SlipPresenter < Keynote::Presenter
  presents :slip

  def number
    "N° " + (slip.dossier.slips.order(:created_at).index(slip) + 1).to_s
  end

  def recipient = slip.recipient.truncate(40)
  def date = I18n.l(slip.date)

  def show
    render LinkComponent.new(name: "Détails", url: dossier_slip_url(slip.dossier, slip), color: "gray")
  end

  def documents_count
    slip.documents.count
  end
end
