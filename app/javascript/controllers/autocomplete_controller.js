import { Controller } from "stimulus"
import {
  ARROW_UP_KEY,
  ARROW_DOWN_KEY,
  ENTER_KEY,
  ESCAPE_KEY,
  NAVIGATION_KEYS
} from "util/navigationKeys"
import csrfToken from "util/csrfToken"

export default class extends Controller {
  static targets = ["input", "output", "result"]

  connect() {
    // Disable browser autocomplete & spellchecking
    this.inputTarget.setAttribute("autocomplete", "off")
    this.inputTarget.setAttribute("spellcheck", "false")

    this.reset()
  }

  disconnect() {
    this.reset()
  }

  onInputChange(_event) {
    if (this.inputTarget.value == "") {
      this.reset()
      return
    }

    // Reset resultIndex, build query, fetch & display results
    this.resetCurrentResultIndex()
    const url = this.buildQueryURL()
    this.fetchAndDisplayResults(url)
  }

  handleNavigationKeys(event) {
    // Return on non navigation keys
    if (!NAVIGATION_KEYS.includes(event.key)) {
      return
    }

    event.preventDefault()

    // We have some results from server
    if (this.resultTargets.length > 0) {
      switch(event.key) {
      case ARROW_UP_KEY:
        this.selectPreviousResult()
        break
      case ARROW_DOWN_KEY:
        this.selectNextResult()
        break
      case ENTER_KEY:
        this.setCurrentResult()
        break
      case ESCAPE_KEY:
        event.stopPropagation()
        this.reset()
        break
      }
    }
  }

  onBlur(_event) {
    if (this.mouseDown) {
      this.mouseDown = false
      return
    }
    this.reset()
  }

  onMouseDown(_event) {
    this.mouseDown = true
  }

  onMouseClick(event) {
    this.inputTarget.value = event.target.textContent.trim()
    this.inputTarget.focus()
    this.reset()
  }

  reset() {
    this.resetCurrentResultIndex()
    this.hideOutput()
  }

  resetCurrentResultIndex() {
    this.currentResultIndex = null
  }

  hideOutput() {
    this.outputTarget.innerHTML = ""
  }

  buildQueryURL() {
    const url = new URL(this.data.get("url"))
    url.searchParams.append("q", this.inputTarget.value.trim())
    return url
  }

  fetchAndDisplayResults(url) {
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken()
      }
    })
    .then(response => response.text())
    .then(html => this.outputTarget.innerHTML = html)
    .catch(() => {})
  }

  selectNextResult() {
    // Select 1st result
    if (this.currentResultIndex == null) {
      this.currentResultIndex = 0
    } else if (this.currentResultIndex < this.resultTargets.length - 1) {
      this.currentResultIndex++
    // Start from 0 once we go over last result
    } else {
      this.currentResultIndex = 0
    }
  
    this.selectCurrentResult()
  }

  selectPreviousResult() {
    // Select 1st result
    if (this.currentResultIndex == null) {
      this.currentResultIndex = 0
    } else if (this.currentResultIndex > 0) {
      this.currentResultIndex--
    // Don't allow negative index values, fallback to 1st result
    } else {
      this.currentResultIndex = 0
    }
  
    this.selectCurrentResult()
  }

  setCurrentResult() {
    // Nothing to set as value
    if (this.currentResultIndex == null) {
      return
    }
  
    this.inputTarget.value = this.resultTargets[this.currentResultIndex].textContent.trim()
    this.reset()
  }

  selectCurrentResult() {
    this.resultTargets.forEach((element, index) => {
      element.classList.toggle("bg-primary", index == this.currentResultIndex)
    })
  }
}
