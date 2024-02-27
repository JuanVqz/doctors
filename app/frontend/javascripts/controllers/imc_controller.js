import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['height', 'weight', 'result']
  static values = { meter: { type: Number, default: 100 } }

  connect() {
    this.calculate()
  }

  calculate() {
    if (!this.validHeightAndWeight()) {
      return
    }

    this.resultTarget.value = this.formulaResult()
  }

  validHeightAndWeight() {
    return this.heightTarget.value > 0 && this.weightTarget.value > 0
  }

  formulaResult() {
    return (this.weightTarget.value / this.heightAtCube()).toFixed(2)
  }

  heightAtCube() {
    const meters = this.heightTarget.value / this.meterValue
    return (meters * meters)
  }
}
