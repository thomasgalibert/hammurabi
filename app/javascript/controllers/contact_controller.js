import { Controller } from "@hotwired/stimulus"
import { put } from '@rails/request.js'

// Connects to data-controller="contact"
export default class extends Controller {

  static values = {
    id: String,
    main: Boolean,
    dossier: String
  }

  connect() {
  }

  toggle() {
    put(`/dossiers/${this.dossierValue}/contacts/${this.idValue}`, {
      body: JSON.stringify({ contact: { main: !this.mainValue } }),
      responseKind: 'turbo-stream'
    })
  }
}
