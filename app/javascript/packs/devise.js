import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
Rails.start()
Turbolinks.start()

import "css/octicon"
import "css/bootstrap"

import fileUploader from 'fileUploader'
document.addEventListener('turbolinks:load', function() {
  if (document.querySelector('.file-upload')) {
    fileUploader()
  }
})
