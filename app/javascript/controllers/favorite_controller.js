import { Controller } from "stimulus"


export default class extends Controller {

  send(e) {
    e.preventDefault()
    const token = document.querySelector( 'meta[name="csrf-token"]' ).attributes.content.value;
    const heart = e.currentTarget
    const url = `/recipes/${heart.dataset.uid}/favorites`
    const path = heart.dataset.path

    fetch(url, {
        method: "PATCH",
        headers: { "Accept": "application/json", "Content-Type": "application/json", 'X-CSRF-Token': token },
        body:JSON.stringify(
          {
            recipe_id: heart.dataset.uid
          }
        )
      })
      .then(response => response.json())
      .then((data) => {
        if ( data.favorite ) {
          heart.classList.add("fa-red")
        } else {
          heart.classList.remove("fa-red")
        }
      })
  }

}
