import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class PlayVideo extends StatefulWidget {
  final String videoURL;
  final String videoName;
  const PlayVideo({required this.videoName,required this.videoURL});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoURL));
    _controller.setLooping(true);
    _controller.initialize().then((value) => setState(() {
      _controller.play();
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Play video")
      ),
      body:Center(
        child:Column(
          children: [
            AspectRatio(aspectRatio: _controller.value.aspectRatio,
            child:VideoPlayer(_controller)),
            SizedBox(
              height: 20,
            ),
            Text(widget.videoName)

          ],
        )
      )
    );
  }
}
