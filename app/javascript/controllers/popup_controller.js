import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["modal"]

  revealContent() {
    // this.contentTarget.classList.remove("d-none")
    console.log("Hello, Stimulus!", this.element)
    this.modalTarget.classList.remove("bg-modal-hidden")
  }
}
