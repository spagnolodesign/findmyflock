const googleLocation = () => {
  document.addEventListener("DOMContentLoaded", function(event){
    console.log("lòkòlkòkòkòklòklkòkò");
      var placeSearch,
        autocomplete;
      var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
      };
      autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */
      (document.getElementById('locality')), {types: ['geocode']});
      if (autocomplete != null) {
        autocomplete.addListener('place_changed', function(){
          var place = autocomplete.getPlace();
          console.log(place);
          for (var i = 0; i < place.address_components.length; i++) {
            var addressType = place.address_components[i].types[0];
            if (componentForm[addressType]) {
              var val = place.address_components[i][componentForm[addressType]];
              document.getElementById(addressType).value = val;
            }
          }


        });
      }
  })
}
  function fillInAddress() {
  }

  function initAutocomplete(){
  }



export { googleLocation }
