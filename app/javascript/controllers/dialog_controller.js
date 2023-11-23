import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  connect() {
    console.log("Dialog connected")
  }

  close(event) {
    event.preventDefault()
    this.element.classList.add("hidden")
  }
}
