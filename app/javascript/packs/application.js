import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
Rails.start()
Turbolinks.start()

// Stimulus
import "controllers"

require.context("../images/", true, /\.(gif|jpg|png|svg)$/i)

// Turbolinks: remove alert between turbolinks visits
document.addEventListener("turbolinks:before-cache", function() {
  let alert = document.querySelector("div.js-alert")
  if (alert) {
    alert.remove()
  }
})
