window.setupLanguageFilter = function () {
  var $reset = $('#reset-filter'),
      $id = $('#language_id'),
      $list = $('#project-list'),
      $message = $('#projects-message'),
      defaultMessage = $message.text(),
      $refresh = $("#refresh");

  // Handle resetting the filter to all
  function reset() {
    $id.val('');
    change();
  }

  // Handle the filter selection changing
  function change() {
    var languageId = $id.val();
    var url = '/languages/projects/' + languageId;
    $.ajax({
      type: 'GET',
      url: url,
      success: function (htmlData) {
        $list.html(htmlData);
      }
    });
    // Empty string means 'Select Language'
    if (languageId === "") {
      $reset.removeClass('active');
      $refresh.removeClass('active');

      $message.text(defaultMessage);
    } else {
      $message.text('Displaying ' + $id.find("option:selected").text() + ' projects only');
      $reset.addClass('active');
      $refresh.addClass('active');
  }

  // Detect the select change event
  $id.change(change);

  // Detect the reset button being clicked
  $reset.click(reset);
  };
}
