const collapsingButton = () => {
  document.addEventListener("DOMContentLoaded", function(event) {
    let buttons = document.querySelectorAll(".collapsing-button")
    let descriptions = document.querySelectorAll(".collapsing-description")
    buttons.forEach(function(button){
      button.addEventListener("click", toggleDiv)
    });

    function toggleDiv(e) {
      let button = e.target;
      let desc = document.getElementById(button.dataset.value);
      if (desc.classList.contains("expanded")) {
        button.innerText = "Read More"
        desc.classList.remove("expanded")
      }
      else {
        desc.classList.add("expanded")
        button.innerText = "Close"
      }
    }
  });
}

export { collapsingButton }
