$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = $(this.$el.find("input"));
  this.$ul = $(this.$el.find(".users"));
  this.handleInput();
};

$.UsersSearch.prototype.handleInput = function(){
  this.$input.on("keyup", (function(event){


    $.ajax({
      url: "/users/search",
      dataType: "json",
      data: {"query": this.$input.val()},
      success: this.renderResults.bind(this)
    });
  }).bind(this));
};

$.UsersSearch.prototype.renderResults = function (response) {
  console.log(response);

  this.$ul.empty();
  var that = this;
  var $foundUsers = $(response);
  $foundUsers.each(function (idx, user) {
    var $listItem = $('<li></li>');
    var $userLink = $('<a></a>');
    var $button = $('<button></button>');
    var href = "/users/" + user.id;
    var initialState = (user.followed) ? "followed" : "unfollowed";


    $button.attr("class", "follow-toggle")
      .data("initial-follow-state", initialState)
      .data("user-id", user.id).followToggle();

    $userLink.attr("href", href).append(user.username);

    $listItem.append($userLink, $button).appendTo(that.$ul);
    console.log("jesuschrist");
  });
};


$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $(".users-search").usersSearch();
});
