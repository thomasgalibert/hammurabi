import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import { put } from '@rails/request.js'

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    console.log('Sortable controller connected')
    
    Sortable.create(this.element, {
      handle: '.handle',
      filter: ".ignore-elements",
      onEnd: this.onEnd.bind(this)
    })
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl

    put(sortableUpdateUrl, {
      body: JSON.stringify({row_order_position: event.newIndex})
    })
  }
}
