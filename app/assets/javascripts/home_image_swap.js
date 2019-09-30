$(document).on('turbolinks:load', function() {
  var index = 0;
  $('#main-home').addClass('mainImg0');

  function updateImage() {
    $('#main-home').removeClass(`mainImg${index}`);
    index = index + 1 < 3 ? index + 1 : 0;
    $('#main-home').addClass(`mainImg${index}`);
  }

  setInterval(updateImage, 20000);
});
