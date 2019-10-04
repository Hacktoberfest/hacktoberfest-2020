window.setupLanguageFilter = function () {
  var $reset = $('#reset-filter'),
      $id = $('#language_id'),
      $list = $('#project-list'),
      $message = $('#projects-message'),
      defaultMessage = $message.text(),
      $refresh = $("#refresh");

  // Handle resetting the filter to all
  function reset() {
    $id.val('');
    change();
  }

// Handle refreshing issues list
  function refresh() {
      var languageId = $id.val();
      if(languageId == ""){
        // no language selected = do nothing
      }else {
        var url = '/languages/projects/' + languageId;
        $.ajax({
          type: 'GET',
          url: url,
          success: function (htmlData) {
            $list.html(htmlData);
          }
        });
      }
    }

  // Handle the filter selection changing
  function change() {
    var languageId = $id.val();
    var url = '/languages/projects/' + languageId;
    $.ajax({
      type: 'GET',
      url: url,
      success: function (htmlData) {
        $list.html(htmlData);
      }
    });
    // Empty string means 'Select Language'
    if (languageId === "") {
      $reset.removeClass('active');
      $refresh.removeClass('active');
      $message.text(defaultMessage);

      // reset URL to remove original query when filter is removed
      var removeQueryURL = current.split("?")[0];
      console.log(removeQueryURL);
      history.pushState(null, " ", removeQueryURL);
    } else {
      $message.text('Displaying ' + $id.find("option:selected").text() + ' projects only');
      $reset.addClass('active');
      $refresh.addClass('active');

      var changed_url = $id.find("option:selected").text();
      var new_lang_url = changed_url.toLowerCase();
      history.pushState(null, " ", "?language=" + new_lang_url);
  }
}

  // Detect the select change event
  $id.change(change);

  // Detect the reset button being clicked
  $reset.click(reset);


  // Detect the refresh button being clicked
  $refresh.click(refresh);

  // };

  //////////  LANGUAGE QUERY PARAM CODE BELOW //////////

  var current = window.location.href;
  // take URL turn into string, split after '?', convert any '%20" to whtiespace', trim/remove whitespace
  var convertURL = current.toString().toLowerCase().split("?")[1].replace(/%20/g, " ").trim().replace(/\s/g, '');
  var issues = document.getElementsByClassName("lang")[0];
  // store converted URL query in variable
  var query_param = convertURL;
  var lang_select = document.getElementById("language_id");
  var lang_option = document.querySelectorAll("option");
  var textArr = [];
  var final = [];
  var count = 0;

  // compare query_param to items in final text array
  function languageURL() {
      for(var i=0; i<final.length;i++){
        //keep track of index of match
        count++;

        if(query_param == final[i]){
          var indexNum = count - 1;
          var selectedOption = indexNum;

          // set language select option to query param
          lang_select.value = selectedOption;

          // scroll to language select section
          issues.scrollIntoView();

          //change URL based on lang query
          var remove_query = current.split("?")[0];
          var url = new URL(remove_query);
          var query_string = url.search;
          var search_params = new URLSearchParams(query_string);
          search_params.set("language", final[i]);
          url.search = search_params.toString();
          var new_url = url.toString();
          history.pushState(null, " ", new_url);

          change();
        }else{
          // if no match - do nothing
        }
        //end of else
      }
      //end of loop;
  }
  //end of languageURL function

function extractLang() {
  if(convertURL.includes("language=") == true){
    let extract = convertURL.slice(9);
    query_param = extract;
    languageURL();
  }else{
    // there is no 'language=' in the URL so there is no need to extract the query
    // go straight to calling comparison function
    languageURL();
  }
}

  function convertText() {
    for(var k=0; k<textArr.length; k++){
      // turn option items into lowercase
      var lowercase_opt = textArr[k].toLowerCase();
      // remove any whitespace
      var no_space = lowercase_opt.replace(/\s/g, '');
      // final result to compare against query_param
      final.push(no_space);
    }
    extractLang();
  }

  function storeOptionText() {
    for(var j=0; j<lang_option.length; j++){
      textArr.push(lang_option[j].text);
    }
    convertText();
  }

  storeOptionText();  // on page load call first function
}
