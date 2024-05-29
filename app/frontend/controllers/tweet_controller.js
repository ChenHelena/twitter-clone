import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.element.addEventListener('turbo:submit-end', () => {
      this.element.reset();
      document.querySelector('.btn-close').click()
      document.querySelector('.btn-modal').click()
      console.log('click')
    })
  }
}