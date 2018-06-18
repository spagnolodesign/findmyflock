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

export {
  formRequest
}
