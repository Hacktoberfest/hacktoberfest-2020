// Toggle visibility of FAQ items on click

window.onload = function() {
  // Select all elements with 'expand' class and hold in array
  var question =  document.getElementsByClassName("question-answer");
  var answer = document.getElementsByClassName("hidden");
  var expandAll = document.getElementsByClassName("ex-col-all")[0];

  // Expand all questions
    expandAll.addEventListener("click", function(){
      for(var j=0; j<answer.length;j++){
        answer[j].classList.toggle("show");
      }
    })


  // Expand single target item
  for(var i = 0; i< question.length; i++){
    question[i].addEventListener("click", function() {
      let temp = this;
      let content = temp.querySelector(".answer");
      content.classList.toggle("hidden");


    })
  }

}
