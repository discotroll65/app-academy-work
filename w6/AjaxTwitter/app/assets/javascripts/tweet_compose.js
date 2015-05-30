$.TweetCompose = function (el){
  this.$el = $(el);
  this.$content = this.$el.find("textarea");
  this.$mention = this.$el.find("select");
  this.sendingInput = false;
  this.submit();
};

$.TweetCompose.prototype.submit = function(){
  this.$el.on("submit", (function(event){
    if (this.sendingInput){
      return;
    }

    this.sendingInput = true;
    this.$el.find(":input").prop("disabled", true);

    event.preventDefault();
    var params = this.$el.serializeJSON();
    this.$el.find(":input").prop("disabled", false);
    $.ajax({
      type: "POST",
      dataType: "json",
      url: "/tweets",
      data: params,
      success: (this.clearInput).bind(this)
    });

  }).bind(this));
};

$.TweetCompose.prototype.clearInput = function () {
  this.$content.val("");
  this.$mention.find("option").prop("selected", false);
  this.sendingInput = false;
};


$.fn.tweetCompose = function(){
  new $.TweetCompose(this);
};

$(function(){
  $('.tweet-compose').tweetCompose();
})
