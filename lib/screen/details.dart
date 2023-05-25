import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailsPage extends StatefulWidget {
  final String mediaUrl;
  const DetailsPage({super.key, required this.mediaUrl});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  VideoPlayerController? controller;
  @override
  void initState() {
    controller = VideoPlayerController.network(widget.mediaUrl)
      //..addListener(() => setState(() {}))
      //..setLooping(true)
      ..play()
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //alignment: Alignment.center,
              child: controller!.value.isInitialized
                  ? VideoPlayer(controller!)
                  : Container()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
              controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            setState(() {
              controller!.value.isPlaying
                  ? controller!.pause()
                  : controller!.play();
            });
          }),
    );
  }
}
