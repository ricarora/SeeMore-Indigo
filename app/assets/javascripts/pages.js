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
    var unpresent = $(present).siblings(".unsearch_result");
    console.log(unpresent);
    var value = $(this).siblings("div").children()[1];
    var $form = $(this).parents("form");
    $.ajax($form.attr("action"), {
      url: "/search",
      type: "POST",
      data: $form.serialize(),
      // dataType: "script",
      success: function() {
        $(unpresent).removeClass("hide");
        $(present).addClass("hide");
        // The text on the button can be changed here. Feel free to edit relevant unsubscribe message.
      },
      error: function(err) {
        alert("Error!!");
      },
    });
  });

  $(".unsearch_result").click(function(e) {
    e.preventDefault();
      var present = $(this);
      var unpresent = $(present).siblings(".search_result");
      var value = $(this).siblings("div").children()[1];
      var $form = $(this).parents("form");
      $.ajax($form.attr("action"), {
        url: "/search-edit",
        type: "POST",
        data: $form.serialize(),
        // dataType: "script",
        success: function() {
          $(unpresent).removeClass("hide");
          $(present).addClass("hide");
          // The text on the button can be changed here. Feel free to edit relevant unsubscribe message.
        },
        error: function(err) {
          alert("Error!!");
        },
      });
  });

});
