function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== "") {
    const cookies = document.cookie.split(";");
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      // Does this cookie string begin with the name we want?
      if (cookie.substring(0, name.length + 1) === name + "=") {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}
const csrftoken = getCookie("csrftoken");

let addBtns = document.querySelectorAll("#btn-add");
addBtns.forEach(btn => btn.addEventListener("click", addToCart));

let removeBtns = document.querySelectorAll("#btn-delete");
removeBtns.forEach(btn => btn.addEventListener("click", removeFromCart));

function updateCart(url, data) {
  fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json", "X-CSRFToken": csrftoken },
    body: JSON.stringify(data)
  })
    .then((res) => res.json())
    .then((data) => {
      console.log(data);
    })
    .catch(error => {
      throw new Error(error);
    });
}

function addToCart(e) {
    const product_id = e.target.value;
    const url = "../add_to_cart/";
    const data = { id: product_id };

    updateCart(url, data);
}

function removeFromCart(e) {
    const product_id = e.target.value;
    const url = "../remove_from_cart/";
    const data = { id: product_id };

    updateCart(url, data);
}