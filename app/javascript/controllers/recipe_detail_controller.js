import { Controller } from "stimulus"

export default class extends Controller {

    connect() {
        console.log('connected');
    }

    top(event){
      console.log("Top console");
      window.scrollTo(0, 0);
    }
}
