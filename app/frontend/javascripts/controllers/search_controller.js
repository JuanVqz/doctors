import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['field']
  static values = { debounce: { type: Number, default: 500 } }

  connect() {
    this.moveCursorAtTheEndOfTheSearchContent()
  }

  submit() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, this.debounceValue)
  }

  moveCursorAtTheEndOfTheSearchContent() {
    if (!this.hasFieldTarget) {
      return
    }

    let endOfContent = this.fieldTarget.value.length
    this.fieldTarget.setSelectionRange(endOfContent, endOfContent)
    this.fieldTarget.focus()
  }
}
