function showTab(tab, initial) {
    var $a = $('#tabs #' + tab);
    if ($a.length) {
        $('#tabs li a').removeClass('selected');
        $a.addClass('selected');
        if (initial || $a.hasClass('inactive')) {
            $('#tabs li a').addClass('inactive');
            $a.removeClass('inactive');
            $('.tab-block').hide();
            $('#' + tab + '-content').fadeIn('slow');
            if (!initial) {
                window.location.hash = '#' + tab;
            }
        }
    }
}

$(document).on('turbolinks:load', function() {
    var initialTab = window.location.hash;
    if (initialTab) {
        initialTab = initialTab.slice(1);
    }
    if (!initialTab || !$('#tabs #' + initialTab).length) {
        initialTab = $('#tabs li a:first').attr('id');
    }
    showTab(initialTab, true);

    $('#tabs li a').click(function() {
        showTab($(this).attr('id'), false);
    });
});
