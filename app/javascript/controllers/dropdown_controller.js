import { Controller } from "stimulus"
import { createPopper } from "@popperjs/core"

export default class extends Controller {
  static targets = ["button", "menu"]

  disconnect() {
    this.menuTarget.setAttribute("hidden", "")
    this._popperDestroy()
  }

  toggle() {
    this.menuTarget.toggleAttribute("hidden")

    // Menu is open
    if (!this.menuTarget.hasAttribute("hidden")) {
      this._popperCreate()
    // Menu is hidden
    } else {
      this._popperDestroy()
    }
  }

  hide(event) {
    if (
      !this.element.contains(event.target) &&
      !this.menuTarget.hasAttribute("hidden")
    ) {
      this.menuTarget.setAttribute("hidden", "")
      this._popperDestroy()
    }
  }

  _popperCreate() {
    this.popperInstance = createPopper(this.buttonTarget, this.menuTarget)
  }

  _popperDestroy() {
    if (this.popperInstance) {
      this.popperInstance.destroy()
      this.popperInstance = null
    }
  }
}
