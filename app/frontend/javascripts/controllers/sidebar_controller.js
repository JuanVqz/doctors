
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['toggler', 'background', 'aside']

  toggle() {
    this.togglerTarget.querySelectorAll('svg').forEach(el => el.classList.toggle('hidden'))
    this.backgroundTarget.classList.toggle('hidden')
    this.asideTarget.classList.toggle('hidden')
  }
}
