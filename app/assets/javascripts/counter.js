var days, hours, minutes, seconds;

function countdownTimers (element, date) {
  setInterval(function () {
    // find the amount of "seconds" between now and target
    var current_date = new Date().getTime()
    var target_date = Date.parse(date) + 7 * 24 * 60 * 60 * 1000
    var seconds_left = (target_date - current_date) / 1000;
    // do some time calculations
    days = parseInt(seconds_left / 86400);
    seconds_left = seconds_left % 86400;
    hours = parseInt(seconds_left / 3600);
    seconds_left = seconds_left % 3600;
    minutes = parseInt(seconds_left / 60);
    seconds = parseInt(seconds_left % 60);
    countdown = days + "d:" + hours + "h:" + minutes + "m:" + seconds + "s";
    element.innerHTML = "🎉 You’ve submitted the four required PRs for the Hacktoberfest challenge! So long as your PRs successfully pass the review period, they’ll become valid in:" + countdown + " — which means you’ll have officially completed this year’s challenge!"
  }, 1000);
}
