$(document).on("turbolinks:load", function() {

  // Change the link's icon while the request is performing
  $(document).on('click', 'a[data-remote]', function(event, b, c) {
    var icon = $(this).find('i');
    icon.data('old-class', icon.attr('class'));
    icon.attr('class', 'fas fa-sync fa-spin');
  });

  // Change the link's icon back after it's finished.
  $(document).on('ajax:complete', function(e) {
    var icon = $(e.target).find('i');
    if (icon.data('old-class')) {
      icon.attr('class', icon.data('old-class'));
      icon.data('old-class', null);
    }
  })

  // Don't fail silently
  $(document).ajaxError(function( event, jqxhr, settings, exception ) {
    if (jqxhr.status) {
      alert("We're sorry, but something went wrong (" + jqxhr.status + ')');
    }
  });

});