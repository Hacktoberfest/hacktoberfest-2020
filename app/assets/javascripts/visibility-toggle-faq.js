// Toggle visibility of FAQ items on click

window.onload = function() {
  // Select all elements with 'expand' class and hold in array
  var question =  document.getElementsByClassName("question-answer");
  var answer = document.getElementsByClassName("hidden");

  // Expand all questions
  // for(var i = 0; i< question.length; i++){
  //   question[i].addEventListener("click", function(){
  //     for(var j=0; j<answer.length;j++){
  //       answer[j].classList.toggle("show");
  //     }
  //   })
  // }

  // Expand single target item
  for(var i = 0; i< question.length; i++){
    question[i].addEventListener("click", () => {

      //FIXME: THIS CODE WORKS BUT ONLY IF YOU CLICK CERTAIN AREA OF BLOCK (SLIGHTLY BELOW THE CHEVRON )
      let temp = event.target;
      let content = temp.querySelector(".answer");
      console.log(content);
        content.classList.toggle("hidden");
    })
  }

}
