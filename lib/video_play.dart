import 'dart:io';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';


class VideoPlayFile extends StatefulWidget {
  const VideoPlayFile({Key? key, required this.file}) : super(key: key);


  final File file;
  @override
  _VideoPlayFileState createState() => _VideoPlayFileState();
}

class _VideoPlayFileState extends State<VideoPlayFile> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
        widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.indigo,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: _controller!.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}