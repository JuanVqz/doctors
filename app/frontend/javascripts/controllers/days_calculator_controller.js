import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['starting', 'ending', 'days']

  connect() {
    this.calculate()
  }

  calculate() {
    if (this.startingTarget.value && this.endingTarget.value) {
      const startDate = new Date(this.startingTarget.value)
      const endDate = new Date(this.endingTarget.value)

      const diffTime = Math.abs(endDate - startDate)
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))

      this.daysTarget.value = diffDays
    }
  }
}
