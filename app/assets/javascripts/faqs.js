window.addEventListener("click", (e) => {
    var $target = $(e.target);
    if ($target.hasClass("toggle")) {
      $target.toggleClass("active");
      $target.next().toggleClass("answer-show");
    } else if ($target.hasClass("active")) {
      $target.toggleClass("toggle");
      $target.next().toggleClass("answer-show");
    }
  
    if ($target.is("p")) {
      var $toggle = $target.parent().next();
      if ($toggle.hasClass("toggle")) {
        $toggle.toggleClass("active");
        $toggle.next().toggleClass("answer-show");
      } else if ($toggle.hasClass("active")) {
        $toggle.toggleClass("toggle");
        $toggle.next().toggleClass("answer-show");
      }
    }
 });
