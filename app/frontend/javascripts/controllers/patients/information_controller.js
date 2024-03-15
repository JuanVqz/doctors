import { Controller } from '@hotwired/stimulus'
import { get } from '@rails/request.js'

export default class extends Controller {
  initialize() {
    if (!this.element.selectedIndex) {
      return this.hidePatientInformation()
    }

    this.fetch()
  }

  async fetch() {
    let patient_id = this.element.options[this.element.selectedIndex].value
    await get(`/patients/${patient_id}/information`, { responseKind: 'turbo-stream' })
    document.querySelector('turbo-frame[id=patient_information]').classList.remove('hidden')
  }

  hidePatientInformation() {
    document.querySelector('turbo-frame[id=patient_information]').classList.add('hidden')
  }
}
