window.addEventListener("click", (e) => {
    $target = $(e.target),
    $form_first = $('#form-first'),
    $form_second = $('#form-second'),
    $video = Wistia.api('u8up7h2m32'),
    $quality_checkers = $('.check-extra')

    if ($target.attr('data-js') === "continue" ) {
        $form_first.toggleClass('hidden');
        $form_second.toggleClass('hidden');
    } else if ($target.attr('data-js') === "back") {
        $form_first.toggleClass('hidden');
        $form_second.toggleClass('hidden');
    }

    $video.bind("end", function() {
        $quality_checkers.each(function() {
            $(this).removeAttr('disabled');     
        });
    });

});