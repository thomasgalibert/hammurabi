import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'
import { useClickOutside } from 'stimulus-use'

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "input", "results" ]

  static values = {
    url: String
  }

  connect() {
    useClickOutside(this)
  }

  async search() {
    const query = this.inputTarget.value
    
    if (query === "") {
      this.resultsTarget.innerHTML = ""
    } else {
      const response = await get(`${this.urlValue}.json?query=${query}`)

      if (response.ok) {
        response.json.then((results) => {
          this.updateResults(results)
        });
      }
    }
  }

  close(event) {
    event.preventDefault();
    this.inputTarget.value = ""
    this.resultsTarget.innerHTML = ""
  }

  updateResults(results) {
    this.resultsTarget.innerHTML = "";

    results.forEach((result) => {
      const listItem = document.createElement("li")
      listItem.classList.add("px-2", "py-1", "hover:bg-amber-100", "cursor-pointer")
      listItem.innerHTML = `<a href="${result.url}">${result.name}</a>`
      this.resultsTarget.appendChild(listItem)
    });
  }

}
