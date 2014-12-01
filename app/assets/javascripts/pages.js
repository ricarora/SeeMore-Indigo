// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// Ajax for subscribe & unsubscribe

$(function() {

  // this function shows the edit deets form on show page
  $("#display_profile").click(function(e) {
    e.preventDefault();
    $(this).hide();
    $('#edit_profile').show();
  });

  // this function prevents users from searching an empty string
  var searchForm = $(".search-header").children("form");
  searchForm.submit(function(e) {
    if ($("#search").val() === "") {
      e.preventDefault();
    }
  });


  //this function is for unsubscribing on the show page
  $(".edit_subscription").submit(function(e) {
    e.preventDefault();
    var $form = $(this);
    $.ajax({
      url: "/remove_subscription",
      type: "POST",
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
    $.ajax({
      url: "/subscriptions",
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
      e.preventDefault();
      var current = $(this);
      var current_hidden = $(current).siblings(".search_result");
      // var value = $(this).siblings("div").children()[1];
      var $form = $(this).parents("form");
      $.ajax({
        url: "/remove_subscription",
        type: "POST",
        data: $form.serialize(),
        success: function() {
          $(current_hidden).removeClass("hide");
          $(current).addClass("hide");
        },
        error: function(err) {
          alert("Error!!");
        },
      });
  });

});
