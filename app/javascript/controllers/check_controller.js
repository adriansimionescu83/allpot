import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["checkbox", "form", "checkboxall"]

  connect() {
    console.log("The 'check_all_checkboxes' controller is now loaded!")
  }

  checkAll() {
    if (this.checkboxallTarget.checked) {
      this.checkboxTargets.forEach((target) => {
        target.checked = true;
      });
    } else {
      this.checkboxTargets.forEach((target) => {
        target.checked = false;
      });
    }
   }

}
