$(function() {
  $('#language_id').change(function(event) {
    var languageId = $(event.currentTarget).val();
    var url = "/languages/projects/" + languageId;
    $.ajax({
      type: "GET",
      url: url,
      success: function(htmlData) {
        $('#project-list').html(htmlData);
      }
    })
  })
});

function updateFilterText() {
  //toggle button visibility
}
