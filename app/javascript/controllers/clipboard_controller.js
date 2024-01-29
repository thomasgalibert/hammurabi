import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy"
export default class extends Controller {
  static targets = [ "source", "tooltip" ]
  
  copy(event){
    event.preventDefault()
    navigator.clipboard.writeText(this.sourceTarget.value)

    // Tooltip appears
    this.tooltipTarget.classList.remove("hidden")
    setTimeout(() => {
      this.tooltipTarget.classList.add("hidden")
    }, 1000)
  }
}
