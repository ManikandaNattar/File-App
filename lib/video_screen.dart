import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen(
      {Key? key, required this.videoFilePath, required this.screen})
      : super(key: key);
  final XFile videoFilePath;
  final String screen;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  @override
  void initState() {
    _initVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    videoPlayerController!.dispose();
    chewieController!.dispose();

    super.dispose();
  }

  _initVideoPlayer() {
    videoPlayerController =
        VideoPlayerController.file(File(widget.videoFilePath.path));
    videoPlayerController!.addListener(() {
      setState(() {});
    });
    videoPlayerController!.initialize().then((value) {
      setState(() {});
    });
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      aspectRatio: 5 / 8,
      autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Video Screen",
        ),
        // actions: [
        //   Visibility(
        //     visible: widget.screen == "Folder",
        //     child: TextButton(
        //       onPressed: () {},
        //       child: const Text(
        //         "SAVE",
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Chewie(
        controller: chewieController!,
      ),
    );
  }
}
