import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_anixi/pages/PlayVideo.dart';
import 'package:video_player/video_player.dart'; // Import the video_player package

class VideoLists extends StatefulWidget {
  const VideoLists({Key? key});

  @override
  State<VideoLists> createState() => _VideoListsState();
}

class _VideoListsState extends State<VideoLists> {
  late List<VideoPlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = [];
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
  Color myColor = const Color.fromARGB(255, 74, 95, 86);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
          centerTitle: true,
          title: Text(
              "Video Upload",
            style: TextStyle(
             color: Colors.white
            ),
          )
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Videos").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              final videos = snapshot.data?.docs.reversed.toList();
              return ListView.builder(
                itemCount: videos?.length,
                itemBuilder: (context, index) {
                  final video = videos![index];
                  final videoController = VideoPlayerController.network(video["Url"]);
                  _controllers.add(videoController);
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: VideoListItem(
                        videoController: videoController,
                        videoName: video["Name"],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class VideoListItem extends StatefulWidget {
  final VideoPlayerController videoController;
  final String videoName;

  const VideoListItem({
    Key? key,
    required this.videoController,
    required this.videoName,
  }) : super(key: key);

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    _isPlaying = false;
    widget.videoController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPlaying = !_isPlaying;
          if (_isPlaying) {
            widget.videoController.play();
          } else {
            widget.videoController.pause();
          }
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: widget.videoController.value.aspectRatio,
            child: VideoPlayer(widget.videoController),
          ),
          if (!_isPlaying)
            Icon(
              Icons.play_circle_outline,
              size: 50,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.videoController.dispose();
    super.dispose();
  }
}