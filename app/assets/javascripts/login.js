// $(document).ready(function() {
//   $('.login').on('click', function(event){
//     event.preventDefault();
//     console.log("displaay")
//   $("#home_login_form").css('visibility','visible');
//   $("#home_login_form").css('display','block');

//   })
// });

$(document).ready(function() {
function showLoginForm(){
 console.log("showLoginForm is called")

 // setTimeout(function(){
  $("#home-login-form").show()//},44);
}
  $("#home-login").click(function(event) {
    event.preventDefault();
    console.log("sign in button event")
    showLoginForm();

  });
});





