// // // Toggle visibility of FAQ items on click
//
// $( function() {
//   // Select all elements with 'expand' class and hold in array
//   var question =  document.getElementsByClassName("question-answer");
//   var answer = document.getElementsByClassName("hidden");
//   var expandAll = document.getElementsByClassName("ex-col-all")[0];
//   var details = document.querySelectorAll("details");
//   var count = 0;
//   var top = document.getElementById("back-to-top");
//
//   top.addEventListener("click", function(){
//     window.scrollTo(0, 0);
//   })
//
//   function testFunction(){
//     var x =+ count + 1;
//     count = x;
//     for(var i = 0; i< details.length; i++){
//       if(count !== 0 && count % 2 ===0){
//         details[i].removeAttribute("open", " ");
//         expandAll.innerHTML = "Expand All";
//       }
//       else{
//         details[i].setAttribute("open", " ");
//         expandAll.innerHTML = "Collapse All";
//
//       }
//     }
//   }
//
// // Expand all questions
//   expandAll.addEventListener("click", testFunction)});
//
// window.addEventListener('hashchange', function() {
//   console.log('The hash has changed!')
//   expandAll.addEventListener("click", testFunction);
// }, false);
