import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "form", "checkboxall"]

  connect() {
    console.log("The 'check_all_checkboxes' controller is now loaded!")

  }

  checkAll(event) {
    this.checkboxTargets.forEach((target) => {
      target.checked = this.checkboxallTarget.checked;
    });
   }
}
