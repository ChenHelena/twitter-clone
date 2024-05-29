import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.element.addEventListener('click', (e) => {
      if(![e.target.dataset.ignoreClick, e.target.parentElement.dataset.ignoreClick].includes('true')){
        Turbo.visit(this.element.dataset.tweetPath)
      }
    })
  }
}