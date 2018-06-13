
const displayLocationInfo = () => {
  let office = document.getElementById('developer_remote_office')
  let locationInfo = document.getElementById('location-info')
  if (!office) return;

  if (office != null && office.checked) {
    locationInfo.classList.add("show_in_user_form")
  }
  if (office != null && !office.checked) locationInfo.classList.add("hide_in_user_form")
  if (office != null){
    office.addEventListener("change", function() {
      if (office.checked){
        locationInfo.classList.remove("hide_in_user_form")
        locationInfo.classList.add("show_in_user_form")
      } else {
        locationInfo.classList.remove("show_in_user_form")
        locationInfo.classList.add("hide_in_user_form")
      }
    })
  }
}


const rangeDistance = () => {
  var rangeDistance = document.getElementById('range-distance');
  var slider = document.getElementById('developer_mobility');
  if (slider != null){
    slider.addEventListener("input", function(){
      rangeDistance.innerHTML = "";
      rangeDistance.innerHTML = `${slider.value} Mi`;
    })
  }
}

const hideRange = () => {
  var selectDistance = document.getElementById('select-distance')
  var fullMobility = document.getElementById('developer_full_mobility')
  if (!fullMobility) return;

  if (fullMobility != null && fullMobility.checked) selectDistance.classList.add("hide_in_user_form")
  if (fullMobility != null && !fullMobility.checked) selectDistance.classList.add("show_in_user_form")

  if (fullMobility != null) {
    fullMobility.addEventListener("change", function(){
      if (!fullMobility.checked){
        selectDistance.classList.remove("hide_in_user_form")
        selectDistance.classList.add("show_in_user_form")
      } else {
        selectDistance.classList.remove("show_in_user_form")
        selectDistance.classList.add("hide_in_user_form")
      }
    })
  }

}

const rangeSalary = () => {
  var salaryAmount = document.getElementById('salary')
  var slider = document.getElementById('developer_min_salary')
  if (slider != null){
    slider.addEventListener("input", function(){
      salaryAmount.innerHTML = ""
      salaryAmount.innerHTML = `${slider.value} $`
    })
  }
}



export {displayLocationInfo}
export {rangeDistance}
export {hideRange}
export {rangeSalary}
