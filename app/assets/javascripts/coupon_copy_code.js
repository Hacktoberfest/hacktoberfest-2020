function copyCodeToClipboard () {
  code = document.getElementById('winner-code')
  code.select();
  code.setSelectionRange(0, 99999); // For mobile devices
  document.execCommand("copy");
}
