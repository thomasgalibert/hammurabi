import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["time"]

  connect() {
    this.currentTime()
    this.interval = setInterval(() => {
      this.currentTime()
    }, 1000)
  }

  currentTime() {
    const date = new Date()
    const time = date.toLocaleTimeString()
    this.timeTarget.innerHTML = time
  }
}