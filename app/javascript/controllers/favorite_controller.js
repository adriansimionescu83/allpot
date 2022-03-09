import { Controller } from "stimulus"


export default class extends Controller {

  stopRefresh(e) {
    const token = document.querySelector( 'meta[name="csrf-token"]' ).attributes.content.value;
    e.preventDefault()
    const heart = e.currentTarget
    console.log(heart)
    const url = `/recipes/${heart.dataset.uid}/favorites`
    // const url = `ingredients/${heart.dataset.uid}/favorite`
    console.log(url)

    fetch(url, {
        method: "PATCH",
        headers: { 'X-CSRF-Token': token }
      })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
        // 1. get the heart state
        // 2. change the color
        heart.classList.toggle("fa-red");
      })
  }

}
