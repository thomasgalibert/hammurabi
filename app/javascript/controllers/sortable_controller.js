import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import { put } from '@rails/request.js'

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      handle: '.handle',
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