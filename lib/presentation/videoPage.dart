import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPage({required this.controller});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    widget.controller.setLooping(true);
    widget.controller.play();
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    widget.controller.pause();
    super.dispose();
  }

  List<String> modelImages = [
    'assets/model_images/img.png',
    'assets/model_images/black_long_dress.png',
    'assets/model_images/model_3.png',
    'assets/model_images/model_4.png',
    'assets/model_images/model_5.png',
    'assets/model_images/model_6.png',
    'assets/model_images/jewellery.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: Stack(
        children: [
          Center(
            child: widget.controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            )
                : CircularProgressIndicator(),
          ),
          Positioned(
            bottom: 50, // Adjust the distance from the bottom as needed
            left: 0,
            right: 0,
            child: SizedBox(
              height: 100, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: modelImages.length, // Number of suggestion containers
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 100, // Width of each suggestion container
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.primaries[index % Colors.primaries.length],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Image.asset(modelImages[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
          });
        },
        child: Icon(
          widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VideoPage(
      controller: VideoPlayerController.asset('assets/videos/nancy_1.mp4'),
    ),
  ));
}
