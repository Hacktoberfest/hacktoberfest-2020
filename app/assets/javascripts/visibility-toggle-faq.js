// // Toggle visibility of FAQ items on click

window.onload = function() {
  // Select all elements with 'expand' class and hold in array
  var question =  document.getElementsByClassName("question-answer");
  var answer = document.getElementsByClassName("hidden");
  var expandAll = document.getElementsByClassName("ex-col-all")[0];
  var details = document.querySelectorAll("details");
  var count = 0;

  // Expand all questions
    expandAll.addEventListener("click", function(){
      for(var k = 0; k<details.length; k++) {
        console.log(details);
        var x =+ count + 1;
        count = x;
        console.log(count);
        for(var i = 0; i< details.length; i++){
          if(count !== 0 && count % 2 ===0){
            details[i].removeAttribute("open", " ");
            console.log("dog");
          }
          else{
            details[i].setAttribute("open", " ");
            console.log("cat");
          }
        }
      }
    })


//   // Expand single target item
//   for(var i = 0; i< question.length; i++){
//     question[i].addEventListener("click", function() {
//       let temp = this;
//       let content = temp.querySelector(".answer");
//       content.classList.toggle("hidden");
//
//
//     })
//   }
//
}
