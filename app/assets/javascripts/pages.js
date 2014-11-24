// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
function toggle_visibility(id) {
  var e = document.getElementById(id);
  if(e.style.display == 'block') {
    e.style.display = 'none';
  } else {
    e.style.display = 'block';
  }
  document.getElementById("hide_profile").style.display="none";
}


// Ajax for subscribe & unsubscribe

$(function() {
  $(".search_result").click(function(e) {
    e.preventDefault();
    var $form = $(this).parents("forms");
    $.ajax($form.attr("action"), {
      type: "POST", success: function() {
        $(this).addClass("btn btn-warning");
      },
      error: function() {
        alert("ERROR!");
      }
    });
  });

});
