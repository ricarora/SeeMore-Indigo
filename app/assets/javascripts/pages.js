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

  $(".edit-subscription").submit(function(e) {
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


//  This will subscribe the result on a search page
  $(".search_result").click(function(e) {
    e.preventDefault();
    var current = $(this);
    var current_hidden = $(current).siblings(".unsearch_result");
    // var value = $(this).siblings("div").children()[1];
    var $form = $(this).parents("form");
    $.ajax($form.attr("action"), {
      url: "/search",
      type: "POST",
      data: $form.serialize(),
      // dataType: "script",
      success: function() {
        $(current_hidden).removeClass("hide");
        $(current).addClass("hide");
      },
      error: function(err) {
        alert("Error!!");
      },
    });
  });


//  This will unsubscribe the result on a search page
  $(".unsearch_result").click(function(e) {
    // e.preventDefault();
      var current = $(this);
      var current_hidden = $(current).siblings(".search_result");
      // var value = $(this).siblings("div").children()[1];
      var $form = $(this).parents("form");
      $.ajax($form.attr("action"), {
        url: "/unsubscribe-searchresult",
        type: "POST",
        data: $form.serialize(),
        success: function() {
          $(current_hidden).removeClass("hide");
          $(current).addClass("hide");
        },
        // error: function(err) {
        //   alert("Error!!");
        // },
      });
  });

});
