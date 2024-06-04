import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController videoPlayerController;
  late VideoPlayerController _playerController;
  late ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
      ),
    );
    videoPlayerController.initialize().then((value) => setState(() {}));
    _playerController =VideoPlayerController.networkUrl(Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4'));
    _playerController.initialize().then((value) => setState(() {}));
    chewieController = ChewieController(videoPlayerController: _playerController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Screen'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: VideoPlayer(videoPlayerController),
          ),
          const SizedBox(height: 20,),
          AspectRatio(
            aspectRatio: _playerController.value.aspectRatio,
            child: Chewie(controller: chewieController),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              videoPlayerController.play();
            },
            icon: const Icon(Icons.play_circle),
          ),
          IconButton(
            onPressed: () {
              videoPlayerController.pause();
            },
            icon: const Icon(Icons.pause_circle),
          )
        ],
      ),
    );
  }
}