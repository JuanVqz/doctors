import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { minHeight: { type: Number, default: 20 } }

  update() {
    this.element.style.height = '1px'
    this.element.style.height = `${this.currentHeight()}px`
  }

  currentHeight() {
    return this.minHeightValue + this.element.scrollHeight
  }
}
