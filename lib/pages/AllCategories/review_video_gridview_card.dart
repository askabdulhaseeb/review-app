import 'package:flutter/material.dart';
import 'package:reviewapp/database/users_firebase_methods.dart';
import 'package:reviewapp/model/app_user.dart';
import 'package:reviewapp/model/review.dart';
import 'package:reviewapp/utils/assets_images.dart';
import 'package:video_player/video_player.dart';

class ReviewVideoCardWidget extends StatefulWidget {
  // final String url;
  // final String reviewID;
  // final String title;
  // final int views;

  // const ReviewVideoCardWidget({
  //   @required this.url,
  //   @required this.reviewID,
  //   @required this.title,
  //   @required this.views,
  // });
  final Review review;
  const ReviewVideoCardWidget({@required this.review});

  @override
  _ReviewVideoCardWidgetState createState() => _ReviewVideoCardWidgetState();
}

class _ReviewVideoCardWidgetState extends State<ReviewVideoCardWidget> {
  VideoPlayerController controller;
  AppUser _user;

  _getUserinfo() async {
    // print('Reviewer Id: ${widget.reviewID}');
    var doc = await UsersFirebaseMethods().getUserInfo(uid: widget.review.uid);
    _user = AppUser.fromDocument(doc);
    print('User Name: ${_user.getDisplayName}');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUserinfo();
    controller = VideoPlayerController.network(widget.review.videoURL)
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
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: VideoPlayer(controller),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 64,
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            color: Colors.orange.shade100,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      (_user?.getImageURL == null || _user.getImageURL == '')
                          ? AssetImage(iAppLogo)
                          : NetworkImage(_user.getImageURL),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        widget.review?.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _user?.getDisplayName ?? 'No name found',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Views: ${widget.review?.views.toString()}',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
