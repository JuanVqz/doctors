import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "element" ]
  static values = { minHeight: { type: Number, default: 20 } }

  update() {
    this.elementTarget.style.height = '1px'
    this.elementTarget.style.height = `${this.currentHeight()}px`
  }

  currentHeight() {
    return this.minHeightValue + this.elementTarget.scrollHeight
  }
}
