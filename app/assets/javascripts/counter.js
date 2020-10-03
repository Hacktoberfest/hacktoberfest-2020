var days, hours, minutes, seconds, reloading;

function countdownTimers (element, date) {
  setInterval(function () {
    // Find the amount of "seconds" between now and target
    var current_date = new Date().getTime();
    var target_date = Date.parse(date) + 14 * 24 * 60 * 60 * 1000;
    var seconds_left = (target_date - current_date) / 1000;

    // Reload the page when the user hits 0
    if (Math.round(seconds_left) === 0 && !reloading) {
        reloading = true;
        setTimeout(function() {
            window.location.reload();
        }, 500);
    }

    // Don't update below zero whilst reloading
    if (Math.round(seconds_left) < 0 && reloading) return;

    // Do some time calculations
    days = parseInt(seconds_left / 86400);
    seconds_left = seconds_left % 86400;
    hours = parseInt(seconds_left / 3600);
    seconds_left = seconds_left % 3600;
    minutes = parseInt(seconds_left / 60);
    seconds = parseInt(seconds_left % 60);
    countdown = days + "d:" + hours + "h:" + minutes + "m:" + seconds + "s";
    element.innerHTML =  countdown
  }, 1000);
}
