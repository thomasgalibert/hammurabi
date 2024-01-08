import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select"
export default class extends Controller {
  static targets = [ "trigger", "zone" ]
  static values = { matches: Array }

  connect() {
    const zone = this.zoneTarget
    const valueSelected = this.triggerTarget.value
    const matchingValueFound = this.matchesValue.find((match) => match == valueSelected)

    if (matchingValueFound) {
      if (zone.classList.contains("hidden")) {
        zone.classList.remove("hidden")
      }
    } else {
      zone.classList.add("hidden")
    }
  }

  toggle(event) {
    event.preventDefault()
    const zone = this.zoneTarget
    const valueSelected = this.triggerTarget.value
    const matchingValueFound = this.matchesValue.find((match) => match == valueSelected)

    if (matchingValueFound) {
      if (zone.classList.contains("hidden")) {
        zone.classList.remove("hidden")
      }
    } else {
      zone.classList.add("hidden")
    }
  }
}
