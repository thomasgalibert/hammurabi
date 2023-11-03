import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["flash"]

  hideFlash() {
    this.flashTarget.classList.add("hidden")
  }

  close() {
    this.hideFlash()
  }
}
