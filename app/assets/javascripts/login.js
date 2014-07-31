$(document).ready(function() {
function showLoginForm(){
 console.log("showLoginForm is called")

  $("#home-login-form").show()
	$("#home-signup-form").hide()
}
  $("#home-login").click(function(event) {
    event.preventDefault();
    console.log("sign in button event")
    showLoginForm();

  });
});





