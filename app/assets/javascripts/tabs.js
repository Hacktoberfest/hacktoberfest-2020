$(document).ready(function() {
  $('#tabs li a:first').addClass('selected');
  $('#tabs li a:not(:first)').addClass('inactive');
  $('.tab-block').hide();
  $('.tab-block:first').show();

  $('#tabs li a').click(function() {
    var t = $(this).attr('id');
    $('#tabs li a').removeClass('selected');

    if ($(this).hasClass('inactive')) {
      //this is the start of our condition
      $('#tabs li a').addClass('inactive');
      $(this).removeClass('inactive');
      $(this).addClass('selected');

      $('.tab-block').hide();
      $('#' + t + 'C').fadeIn('slow');
    }
  });
});
