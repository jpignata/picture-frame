// Generated by CoffeeScript 1.4.0
(function() {
  var source;

  source = new EventSource("/subscribe");

  source.addEventListener("picture", function(event) {
    var data;
    data = JSON.parse(event.data);
    return $("body, input").trigger("changeBackground", [data.url, data.keyword]);
  });

  jQuery(function() {
    $("body").bind("changeBackground", function(event, url, keyword) {
      return $(this).css({
        "background": "url(" + url + ") no-repeat center center fixed",
        "-webkit-background-size": "cover",
        "-moz-background-size": "cover",
        "background-size": "cover"
      });
    });
    $("input").bind("changeBackground", function(event, url, keyword) {
      return $(this).val("").attr("placeholder", keyword);
    });
    $("form").submit(function(event) {
      var input;
      event.preventDefault();
      input = $(this).find("input");
      return $.post("/publish", {
        keyword: input.val()
      });
    });
    return $("input").focus();
  });

}).call(this);