import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from 'stimulus-use'

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu" ]

  connect() {
    useClickOutside(this)
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  close(event) {
    event.preventDefault()
    this.menuTarget.classList.add("hidden")
  }
}
