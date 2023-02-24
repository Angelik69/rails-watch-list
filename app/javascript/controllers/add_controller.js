import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add"
export default class extends Controller {
static targets = ['form', 'button']

  connect() {
    console.log('add ok')
  }

  show() {
    this.buttonTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }
}
