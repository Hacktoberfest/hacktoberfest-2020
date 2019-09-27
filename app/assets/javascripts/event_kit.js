$(document).on('turbolinks:load', function() {
  if (window.location.href.includes('form')) {
    $('.modal').addClass('is-active')
  }
  $('#close-modal').click(function() {
    $('.modal').removeClass('is-active')
  });
});
