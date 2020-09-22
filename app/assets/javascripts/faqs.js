$(document).on('turbolinks:load', function() {
  $('.question-answer').click(function() {
    $answer = $(this).closest('div').find('.answer');
    $answer.toggle();
  });
});
