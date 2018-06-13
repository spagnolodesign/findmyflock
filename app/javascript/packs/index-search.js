
const formRequest = () => {
  document.addEventListener("DOMContentLoaded", function() {
    let checkboxes = document.querySelectorAll("input[type=checkbox]");
      for (let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener( 'change', function() {
            let form = document.getElementById('filter');
            console.log(form);

            Rails.fire(form, 'submit');
        });
      }

  });
}


export {formRequest}
