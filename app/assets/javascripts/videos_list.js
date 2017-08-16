ZiggeoApi.Videos.index({}, {
	success: function (args, videos) {
		// videos is an array of all the videos
		// the following code dynamically adds all the videos to the page
		for (var i = 0; i < videos.length; ++i) {
			$("body").append("<ziggeo ziggeo-video='" + videos[i].token + "'></ziggeo>");
		}
	}
});
