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

  var searchForm = $(".search-header").children("form");
  searchForm.submit(function(e) {
    if ($("#search").val() === "") {
      e.preventDefault();
    }
  });

  $(".unsubscribe").submit(function(e) {
    e.preventDefault();
    var $form = $(this);
    $.ajax($form.attr("action"), {
      data: $form.serialize(),
      success: function() {
        $form.parent().hide();
      },
      error: function() {
        alert("Error!");
      }
    });
  });

  var $search = $(".search_result");
  $search.click(function(e) {
    e.preventDefault();
    var present = $(this);
    var value = $(this).siblings("div").children()[1];
    var $form = $(this).parents("form");
    $.ajax($form.attr("action"), {
      url: "/search",
      type: "POST",
      data: $form.serialize(),
      // dataType: "script",
      success: function() {
        $(present).addClass("btn btn-warning");
        // The text on the button can be changed here. Feel free to edit relevant unsubscribe message.
        $(present).val("Nah, its not right!");
      },
      error: function(err) {
        alert("Error!!");
      },
    });
  });
});
