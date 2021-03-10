import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
Rails.start()
Turbolinks.start()

// Octicons
import "css/octicon"

// Bootstrap
import "bootstrap"
import "css/bootstrap"

// Trix Editor
import "trix/dist/trix.css"
import "trix/dist/trix-core.js"

// Stimulus
import "controllers"

// Datepicker
import "flatpickr/dist/flatpickr.css"
import flatpickr from "flatpickr"

import fileUploader from "fileUploader"
document.addEventListener("turbolinks:load", function() {
  if (document.querySelector(".file-upload")) {
    fileUploader()
  }
})

document.addEventListener("turbolinks:load", function() {
  // Setup date-picker for updating date of the next shipment
  flatpickr("#shipment_next_date_date", {
    minDate: "today"
  });
})

// Turbolinks: remove alert between turbolinks visits
document.addEventListener("turbolinks:before-cache", function() {
  let alert = document.querySelector("div.js-alert")
  if (alert) {
    alert.remove()
  }
})
