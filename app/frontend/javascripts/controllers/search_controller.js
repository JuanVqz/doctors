import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['field']
  static values = { debounce: { type: Number, default: 500 } }

  connect() {
    if (!this.hasFieldTarget) {
      return
    }

    this.fieldTarget.focus()
    this.fieldTarget.select()
  }

  submit() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, this.debounceValue)
  }
}
