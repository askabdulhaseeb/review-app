import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String _videoUrl;

  const VideoWidget(
    String videoUrl, {
    Key key,
  })  : _videoUrl = videoUrl,
        super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print('video URL: ${widget._videoUrl}');
    if (widget._videoUrl != null) {
      _controller = VideoPlayerController.network(widget._videoUrl)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => _controller.play());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayer(_controller),
        Center(
          child: IconButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            iconSize: 45,
            icon: Icon(
              (_controller?.value?.isPlaying == true)
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
