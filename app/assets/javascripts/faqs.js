window.addEventListener('click', (e) => {
	var $target = $(e.target);
	e.preventDefault();
	if ($target.hasClass('toggle')) {
		$target.removeClass('toggle');
		$target.addClass('active');
		$target.next().toggle();
	} else if ($target.hasClass('active')) {
		$target.removeClass('active');
		$target.addClass('toggle');
		$target.next().toggle();
	}
});
