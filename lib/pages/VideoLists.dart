import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_anixi/pages/PlayVideo.dart';

class VideoLists extends StatefulWidget {
  const VideoLists({super.key});

  @override
  State<VideoLists> createState() => _VideoListsState();
}

class _VideoListsState extends State<VideoLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Upload")),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Videos").snapshots(),
                builder: (context, snapshot) {
                  List<Row> videoWidgets = [];
                  if (!snapshot.hasData) {
                    const CircularProgressIndicator();
                  } else {
                    final videos = snapshot.data?.docs.reversed.toList();
                    for (var video in videos!) {
                      final videoWidget = Row(
                        children: [
                          Text(video["Name"]),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return PlayVideo(
                                    videoName: video["Name"],
                                    videoURL: video["Url"],
                                  );
                                }));
                              },
                              icon: Icon(Icons.play_arrow_rounded))
                        ],
                      );
                      videoWidgets.add(videoWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: videoWidgets,
                    ),
                  );
                })
          ],
        ),
      )),
    );
  }
}
