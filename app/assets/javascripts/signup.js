$(document).ready(function() {
function showSignupForm(){
 console.log("showSignupForm is called")

 // setTimeout(function(){
  $("#home-signup-form").show()//},44);
}
  $(".signup").click(function(event) {
    // event.preventDefault();
    console.log("sign up button event")
    showSignupForm();

  });
});
