import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['field']

  connect() {
    if (!this.hasFieldTarget) {
      return
    }

    this.fieldTarget.focus()
  }
}
