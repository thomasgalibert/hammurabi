import { Controller } from "@hotwired/stimulus"
import { put } from '@rails/request.js'

export default class extends Controller {
  static targets = [ "checkbox" ]

  connect() {
    console.log("todo controller connected")
  }

  toggle() {
    put(`/todos/${this.checkboxTarget.value}/toggle`, {
      body: JSON.stringify({ todo: { completed: this.checkboxTarget.checked } }),
      responseKind: 'turbo-stream'
    })
  }
}