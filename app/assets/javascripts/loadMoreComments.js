$( document ).ready(function() {
  ClickableCommentsLink();
});


function ClickableCommentsLink () {
  $(".more-comments").click(function () {
    $(this).on("ajax:success", function (event) {
      var postId = $(this).data("post-id");
      $("#comments_" + postId).html(event.detail[2].responseText);
      $("#comments-paginator-" + postId).html("show more comments");
      Append.open = true;
      Append.comment = true;
      Append.link = false;
    });
  });
}
