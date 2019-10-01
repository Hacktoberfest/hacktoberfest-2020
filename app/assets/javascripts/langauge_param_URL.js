
window.onload = function() {
  let current = window.location.href;

  function languageURL(lang) {
    var url = new URL("http://localhost:3000/");
    var query_string = url.search;
    var search_params = new URLSearchParams(query_string);

    search_params.set("language", lang);
    url.search = search_params.toString();
    var new_url = url.toString();
    history.pushState(null, " ", new_url);
  }

  var url = window.location.href;
  switch (true) {
    case url == "http://localhost:3000/":
      break;
    case url == "http://localhost:3000/?ruby":
      languageURL("ruby");
      break;
    case url == "http://localhost:3000/?python":
      languageURL("python");
      break;
    case url == "http://localhost:3000/?javascript":
      languageURL("javascript");
      break;
    case url == "http://localhost:3000/?golang":
      languageURL("golang");
      break;
    default: console.log("language not found");

  } //end of switch

} //end of window onload
