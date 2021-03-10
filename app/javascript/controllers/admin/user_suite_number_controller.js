import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "input", "firstName", "lastName" ]

  findUser() {
    fetch('/admin/autocomplete_find_user', {
      method: 'post',
      body: JSON.stringify({ "id": parseInt(this.inputTarget.value) - 1000 }),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      credentials: 'same-origin'
    }).then(data => {
      if (!data.ok) { throw new Error(); }
      return data.json();
    }).then(data => {
        this.firstNameTarget.value = data["first_name"]
        this.lastNameTarget.value = data["last_name"]
    }).catch((err) => {
    })
  }
}
