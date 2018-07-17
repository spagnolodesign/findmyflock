jQuery(function($) {
  $(document).on('click', '#filter-show', function(e) {
    e.preventDefault();
    $('nav.filters').addClass('show');
  });
  $(document).on('click', '#filter-hide', function(e) {
    e.preventDefault();
    $('nav.filters').removeClass('show');
  });
});
