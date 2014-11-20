//Jhoong: I removed require turbolinks
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require moment
//= require fullcalendar
//= require bootstrap.min
//= require underscore
//= require gmaps/google
//= require_tree .

  $(document).ready(function() {
    // Deal with radio button options (choose either advertiser or owner)
    var radio = $('input[name=signup-user]');
    var checkedValue = 0;
    $('.user-option').click(function() {
      checkedValue = radio.filter(':checked').val();
    });
   
    // Click signup button
    $('#signup').click(function(e) {
      e.preventDefault();
   
      $.ajax({
         //First send a post request, get the response back. On successful message back, check the data
         url: "" + window.location.protocol + '//' + window.location.host + "/api/create_user",
         type: "POST",
         /* radio button vals: 0 = advertiser, 1 = owner */
 
         data: JSON.stringify( {username: $('#username-signup').val(), password: $('#password-signup').val(), email: $('#email-signup').val(), company: $('#company-signup').val(), usertype: checkedValue} ),
         contentType: "application/json",
         dataType: "json",
         success: function(data){
           signupSuccess(data);
         },
         failure: function(errorMsg) {
           failure(data);
         }
      });
    })
   
    function signupSuccess(data) {
      var status = data.status;
      if (status == 1) {
        if (checkedValue == 0) {
          window.location.href = window.location.protocol + "//" + window.location.host + '/search';
        }
        else {
          window.location.href = window.location.protocol + "//" + window.location.host + '/listings/new';
        }
      }
      else {
        if (status == -1) {
          // error message
          $('#signup-usernametaken-e').show();
          setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs
         
            // hide error message after five seconds, or it will stay there forever
            $("#signup-usernametaken-e").hide();
         
          }, 5000);
        }
        if (status == -2) {
          // error message
          $('#signup-username-e').show();
          setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs
         
            // hide error message after five seconds, or it will stay there forever
            $("#signup-username-e").hide();
           
          }, 5000);
        }
        if (status == -3) {
          // error message
          $('#signup-password-e').show();
          setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs
         
            // hide error message after five seconds, or it will stay there forever
            $("#signup-password-e").hide();
         
          }, 5000);
        }
        if (status == -4) {
        // error message
          $('#signup-email-e').show();
          setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs
         
            // hide error message after five seconds, or it will stay there forever
            $("#signup-email-e").hide();
         
          }, 5000);
        }
      }
    }
   
    $('#login').click(function(e) {
      e.preventDefault();
      $.ajax({
        //First send a post request, get the response back. On successful message back, check the data
        url: "" + window.location.protocol + '//' + window.location.host + "/api/login",
        type: "POST",
        data: JSON.stringify({username: $('#username-login').val(), password: $('#password-login').val()}),
        contentType: "application/json",
        dataType: "json",
        success: function(data){
          loginSuccess(data);
        },
        failure: function(errorMsg) {
          failure(data);
        }
      });
    })
   
    function loginSuccess(data){
      // Wrong login credentials
      if (data.status == -1) {
     
         // error message
         $('#login-error').show();
         setTimeout(function() { // this will automatically close the alert and remove this if the users doesnt close it in 5 secs
       
          // hide error message after five seconds, or it will stay there forever
          $("#login-error").hide();
       
        }, 5000);
      }
      else if (data.status == 1) {
        window.location.href =  window.location.protocol + '//' + window.location.host + '/search';
      }  
    };
  });  
