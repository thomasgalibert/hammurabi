import { Controller } from "@hotwired/stimulus"
import Dropzone from "dropzone"
import { post } from "@rails/request.js"

// Connects to data-controller="dropzone"
export default class extends Controller {
  static targets = [ "input" ]
  static values = { url: String }

  connect() {
    this.inputTarget.disable = true
    this.inputTarget.style.display = "none"

    const dropzone = new Dropzone(this.element, {
      url: this.urlValue,
      maxFiles: '30',
      maxFilesize: '10',
      autoQueue: true,
      clickable: true,
      maxThumbnailFilesize: '20',
      acceptedFiles: 'application/pdf',
      addRemoveLinks: true,
      dictDefaultMessage: "Déposez vos fichiers ici (pdf, max 10Mo)",
    })  

    dropzone.on("addedfile", file => {
      
      setTimeout(async () => {
        if (file.accepted) {
          const count = parseInt(document.getElementById('documents-count').innerText)
          const position = dropzone.files.indexOf(file);
          const formData = new FormData()
          formData.append('document[fichier]', file)
          formData.append('document[name]', file.name)
          formData.append('document[position]', count+position+1)
          const resp = await post(this.urlValue, {body: formData})
          if (resp.ok) {
            dropzone.removeFile(file)
          }
        }  
      }, 500)
    })
    
  }
}
