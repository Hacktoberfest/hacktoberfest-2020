window.addEventListener('click', (e) => {
	var $target = $(e.target);
	e.preventDefault();
	if ($target.hasClass('toggle')) {
		$target.toggleClass('active');
		$target.next().toggleClass('answer-show');
	} else if ($target.hasClass('active')) {
		$target.toggleClass('toggle');
		$target.next().toggleClass('answer-show');
	}
});
