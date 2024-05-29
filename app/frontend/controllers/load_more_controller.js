import { Controller } from "stimulus"

export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html'}

  connect() {
    window.addEventListener('scroll', () => {
      if((window.innerHeight + Math.round(window.scrollY)) >= document.body.offsetHeight){
        if(this.element.dataset.lastPage === 'false'){
          fetch(`/dashboard?page=${this.element.dataset.nextPage}`, { headers: this.headers })
          .then(response => response.text())
          .then(html => Turbo.renderStreamMessage(html))
        }
      }
    })
  }
}
