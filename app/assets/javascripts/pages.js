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
  var $search = $(".search_result");
  $search.click(function(e) {
    e.preventDefault();
    var value = $(this).siblings("div").children()[1];
    var $form = $(this).parents("form");
    $.ajax($form.attr("action"), {
      url: "/search",
      type: "POST",
      data: $form.serialize(),
      // dataType: "script",
      success: function() {
        console.log($search);
        $(this).addClass("btn btn-warning");
      },
      error: function(err) {
        console.log(err);
        alert($(this).data());
      },
    });
  });

});
