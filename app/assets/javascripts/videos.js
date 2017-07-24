ZiggeoApi.Videos.index({}, {
  success: function (args, videos) {
    for (var i = 0; i < videos.length; ++i)
      $("body").append("<ziggeo ziggeo-video='" + videos[i].token + "'></ziggeo>");
    }
});
