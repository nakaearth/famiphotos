//we wait for page load to be finished (you could use jQuery ready event as well, or any such alternative that you prefer)
ZiggeoApi.Events.on("system_ready", function() {
    //Lets get the ziggeo-recorder element reference
    var element = document.getElementById('myRecorder');

    //now lets get the actual Ziggeo embedding / object that we can use
    var recorder = ZiggeoApi.V2.Recorder.findByElement(element);

    // we can also create a global event to fire each time video was uploaded
    recorder.on("verified", function () {
        alert("The video with token '" + recorder.get('video') + "' has been submitted!");
    });
});
