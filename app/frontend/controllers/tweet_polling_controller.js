import { Controller } from "stimulus"

export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html'}

  connect() {
    const loadMoreButton = this.element.querySelector("#loadMoreButton");
    setInterval(() => {
      if(this.element.dataset.latestTweetId.length > 0){
        fetch(`/tweet_polling?latest_tweet_id=${this.element.dataset.latestTweetId}`, { headers: this.headers })
          .then(response => response.text())
          .then(html => Turbo.renderStreamMessage(html))
      }
    }, 8000)
  }
  
}