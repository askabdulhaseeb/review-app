import 'package:flutter/material.dart';
import 'package:reviewapp/pages/AllCategories/video_widget.dart';
import 'package:video_player/video_player.dart';

class ReviewVideoCardWidget extends StatefulWidget {
  final String url;
  final String reviewID;
  final String title;
  final int views;

  const ReviewVideoCardWidget({
    @required this.url,
    @required this.reviewID,
    @required this.title,
    @required this.views,
  });

  @override
  _ReviewVideoCardWidgetState createState() => _ReviewVideoCardWidgetState();
}

class _ReviewVideoCardWidgetState extends State<ReviewVideoCardWidget> {
  VideoPlayerController controller;
  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: VideoWidget(widget.url),
    );
  }
}
