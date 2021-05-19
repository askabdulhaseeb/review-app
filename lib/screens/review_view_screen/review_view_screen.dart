import 'package:flutter/material.dart';
import 'package:reviewapp/database/reviews_firebase_methods.dart';
import 'package:reviewapp/model/app_user.dart';
import 'package:reviewapp/model/review.dart';
import 'package:reviewapp/pages/AllCategories/video_widget.dart';
import 'package:reviewapp/services/user_local_data.dart';
import 'package:reviewapp/utils/assets_images.dart';
import 'package:reviewapp/utils/color_constants.dart';

class ReviewViewScreen extends StatefulWidget {
  final Review review;
  final AppUser user;
  const ReviewViewScreen({@required this.review, @required this.user});
  @override
  _ReviewViewScreenState createState() => _ReviewViewScreenState();
}

class _ReviewViewScreenState extends State<ReviewViewScreen> {
  @override
  void initState() {
    super.initState();
    if (!widget.review.views.contains(UserLocalData.getUID())) {
      widget.review.views.add(UserLocalData.getUID());
      ReviewsFirebaseMethods().updateReview(
        reviewID: widget.review.reviewID,
        map: widget.review.toMap(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        leading: IconButton(
          color: ColorConstants.blackColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Review',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: double.infinity,
            child: VideoWidget(widget.review.videoURL),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.review.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text('Views: ${widget.review.views.length}'),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: (widget.user?.getImageURL == null ||
                              widget.user.getImageURL == '')
                          ? AssetImage(iAppLogo)
                          : NetworkImage(widget.user.getImageURL),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.user.getDisplayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Review: ${widget.review.rating}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.review.about,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
