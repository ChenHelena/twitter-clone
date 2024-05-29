import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.element.addEventListener('click', (e) => {
      Turbo.visit(this.element.dataset.hashtagPath)
    })
  }
}