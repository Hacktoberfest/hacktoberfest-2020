var days, hours, minutes, seconds;

function countdownTimers (elements, date) {
  setInterval(function () {
    // find the amount of "seconds" between now and target
    var current_date = new Date().getTime()
    var target_date = new Date(date).getTime() + 7 * 24 * 60 * 60 * 1000
    var seconds_left = (target_date - current_date) / 1000;
    // do some time calculations
    days = parseInt(seconds_left / 86400);
    seconds_left = seconds_left % 86400;
    hours = parseInt(seconds_left / 3600);
    seconds_left = seconds_left % 3600;
    minutes = parseInt(seconds_left / 60);
    seconds = parseInt(seconds_left % 60);
    for(i=0; i < elements.length; i++) {
      var element = elements[i];
      countdown = days + "d: " + hours + "h: " + minutes + "m: " + seconds + "s";
      element.innerHTML = countdown
    }
  }, 1000);
}
