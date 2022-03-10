import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["checkbox", "form", "checkboxall", "submit"]

  initialize() {
    this.submitTarget.setAttribute("disabled", "")
  }

  connect() {
    console.log("The 'check_all_checkboxes' controller is now loaded!")
  }



  checkAll() {
    if (this.checkboxallTarget.checked) {
      this.submitTarget.removeAttribute("disabled")
      this.checkboxTargets.forEach((target) => {
        target.checked = true;
      });
    } else {
      this.submitTarget.setAttribute("disabled", "")
      this.checkboxTargets.forEach((target) => {
        target.checked = false;
      });
    }
   }

  disableSubmit() {
      this.submitTarget.setAttribute("disabled", "")

      this.checkboxTargets.forEach((target) => {
        if (target.checked == true) {
          this.submitTarget.removeAttribute("disabled")
        }
      });

    }


}
