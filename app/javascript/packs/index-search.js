const formRequest = () => {
  document.addEventListener("DOMContentLoaded", function() {
    if (document.querySelector("#dashboard-container") != null) {
      let checkboxes = document.querySelectorAll("input[type=checkbox]");
      for (let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener('change', function() {
          let form = document.getElementById('filter');
          Rails.fire(form, 'submit');
        });
      }
    }
  });
}

const filterToggle = () => {
  let cards = document.querySelectorAll(".filter-card")
  if (document.querySelector("#dashboard-container") != null) {
    for (let i = 0; i < cards.length; i++) {
      cards[i].childNodes[1].addEventListener("click", function() {
        let collapse = cards[i].childNodes[3]
        if (collapse.classList.contains("show")) {
          collapse.classList.remove("show")
        } else {
          collapse.classList.add("show")
        }
      })
    }
  }
}

export {
  formRequest
}
export {
  filterToggle
}
