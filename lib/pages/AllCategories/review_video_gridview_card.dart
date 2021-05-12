import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReviewVideoCardWidget extends StatefulWidget {
  final String url;
  // final String reviewID;
  // final String title;
  // final int views;

  const ReviewVideoCardWidget({
    @required this.url,
    // @required this.reviewID,
    // @required this.title,
    // @required this.views,
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
      alignment: Alignment.center,
      child: VideoPlayerWidget(controller: controller),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      (controller != null && controller.value.isInitialized)
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
}

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
        );
}

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => SubCategoryScreen(),
//           ),
//         );
//       },
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: (widget.url == '' || widget.url == null)
//                 ? Image.network(defaultImageUrl)
//                 : Image.network(widget.url),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             left: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(220, 0, 0, 0),
//                     Color.fromARGB(0, 0, 0, 0)
//                   ],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.title,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: ColorConstants.whiteColor,
//                       fontSize: 16,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Spacer(),
//                       Text(
//                         'Views: ${widget.views}',
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           // fontWeight: FontWeight.bold,
//                           color: ColorConstants.whiteColor,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           )
//           // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: Padding(
//           //     padding: EdgeInsets.all(8.0),
//           //     child: Column(
//           //       crossAxisAlignment: CrossAxisAlignment.start,
//           //       mainAxisAlignment: MainAxisAlignment.end,
//           //       children: [
//           //         Text(
//           //           title,
//           //           style: TextStyle(
//           //               fontSize: 12, color: ColorConstants.whiteColor),
//           //         ),
//           //         Padding(
//           //           padding: const EdgeInsets.only(right: 8.0),
//           //           child: Row(
//           //             mainAxisAlignment: MainAxisAlignment.end,
//           //             children: [
//           //               Text(
//           //                 'view',
//           //                 overflow: TextOverflow.ellipsis,
//           //                 style: TextStyle(
//           //                     fontSize: 12, color: ColorConstants.whiteColor),
//           //               ),
//           //               Text(
//           //                 '$views',
//           //                 style: TextStyle(
//           //                     fontSize: 12, color: ColorConstants.whiteColor),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
