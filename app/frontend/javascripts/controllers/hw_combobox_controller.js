import HwComboboxController from "@josefarias/hotwire_combobox"
import { get } from '@rails/request.js'

export default class extends HwComboboxController {
  static values = { fetchInformation: { type: Boolean, default: false } }

  initialize() {
    super.initialize()

    if (!this.hiddenFieldTarget.value) {
      return this.hidePatientInformation()
    }

    this.fetch(this.hiddenFieldTarget.value)
  }

  selectOnClick({currentTarget, inputType}) {
    super.selectOnClick({currentTarget, inputType})

    this.fetch(currentTarget.dataset.value)
  }

  _selectAndAutocompleteFullQuery(option) {
    super._selectAndAutocompleteFullQuery(option)

    this.fetch(option.dataset.value)
  }

  async fetch(patient_id) {
    if (!this.fetchInformationValue) { return }

    await get(`/patients/${patient_id}/information`, { responseKind: 'turbo-stream' })
    this.showPatientInformation()
  }

  hidePatientInformation() {
    document.querySelector('turbo-frame[id=patient_information]') &&
      document.querySelector('turbo-frame[id=patient_information]').classList.add('hidden')
  }

  showPatientInformation() {
    document.querySelector('turbo-frame[id=patient_information]').classList.remove('hidden')
  }
}
