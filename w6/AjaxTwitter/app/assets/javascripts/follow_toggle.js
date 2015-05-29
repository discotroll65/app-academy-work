$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id");
  //will either be "following" or "not-following"
  this.followState = this.$el.data("initial-follow-state");
  this.render();
  this.handleClick();

};

$.FollowToggle.prototype.render = function () {
  var buttonText;
  buttonText = (this.followState === "followed") ? "Unfollow!" : "Follow!";
  this.$el.text(buttonText);
  if (this.followState === "following" ||
      this.followState === "unfollowing") {
    this.$el.prop("disabled", true);
  } else {
    this.$el.prop("disabled", false);
  }
};

$.FollowToggle.prototype.handleClick = function () {
  this.$el.on( "click", (function (event){
    event.preventDefault();
    var httpRequest;
    var toggledState;
    var transitionState;

    if (this.followState === "followed"){
      httpRequest = "DELETE";
      this.followState = "unfollowing";
      toggledState = "unfollowed";
    } else {
      httpRequest = "POST";
      this.followState = "following";
      toggledState = "followed";
    }

    $.ajax(
      {
        type: httpRequest,
        url: "/users/"+ this.userId + "/follow",
        dataType: "json",
        success: (function(){
          this.followState = toggledState;
          this.render();
        }).bind(this)
      }
    );
    this.render();
  }).bind(this) );
};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
