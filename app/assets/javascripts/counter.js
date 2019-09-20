function timer(startDate) {
  var diff = (new Date("2019-11-01 00:00:00 UTC") - startDate) / 1000;

  // clear countdown when date is reached
  if (diff <= 0) {
    return false;
  }
  var days        = Math.floor(diff/24/60/60);
  var hoursLeft   = Math.floor((diff) - (days*86400));
  var hours       = Math.floor(hoursLeft/3600);
  var minutesLeft = Math.floor((hoursLeft) - (hours*3600));
  var minutes     = Math.floor(minutesLeft/60);
  var remainingSeconds = diff % 60;
  function pad(n) {
    return (n < 10 ? "0" + n : n);
  }
  document.getElementById('countdown').innerHTML = pad(days) + "d:" + pad(hours) + "h:" + pad(minutes) + "m:" + pad(remainingSeconds) + "s" ;
  if (diff == 0) {
    clearInterval(countdownTimer);
    document.getElementById('countdown').innerHTML = "Completed";
  } else {
    diff;
  }
}
var countdownTimer = setInterval(() => timer(new Date("2019-10-01 03:40:02 UTC")), 1000);
