$('#tabs li a').click(function() {
  var t = $(this).attr('id');
  console.log(t);
  if ($(this).hasClass('inactive')) {
    //this is the start of our condition
    $('#tabs li a').addClass('inactive');
    $(this).removeClass('inactive');

    $('.panel-block').hide();
    $('#' + t + 'C').fadeIn('slow');
  }
});
