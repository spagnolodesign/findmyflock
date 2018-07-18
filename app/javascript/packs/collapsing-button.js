const collapsingButton = () => {
  document.addEventListener("DOMContentLoaded", function(event) {
    let buttons = document.querySelectorAll(".collapsing-button")
    let descriptions = document.querySelectorAll(".collapsing-description")


      buttons.forEach(function(element){
      element.addEventListener("click", toggleDiv)
    });

    function toggleDiv(e) {
      let element = e.target;
      let desc = document.getElementById(element.dataset.value);
      if (desc.classList.contains("expanded")) {
        element.innerText = "Read More"
        desc.classList.remove("expanded")
      }
      else {
        desc.classList.add("expanded")
        element.innerText = "Close"
      }
    }
  });
}

export { collapsingButton }
