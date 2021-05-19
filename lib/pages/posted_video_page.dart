import 'package:flutter/material.dart';
import 'package:reviewapp/database/reviews_firebase_methods.dart';
import 'package:reviewapp/model/review.dart';
import 'package:reviewapp/pages/AllCategories/review_video_gridview_card.dart';
import 'package:reviewapp/services/user_local_data.dart';
import '../model/review_video.dart';
import '../utils/color_constants.dart';

class PostedVideoPage extends StatefulWidget {
  @override
  _PostedVideoPageState createState() => _PostedVideoPageState();
}

class _PostedVideoPageState extends State<PostedVideoPage> {
  Stream _stream;
  List<Review> reviewList = [];

  _streamFunctionHelper() async {
    _stream = await ReviewsFirebaseMethods().getAllReviewByID(
      uid: UserLocalData.getUID(),
    );
    setState(() {});
  }

  _getUpdatedStream() {
    _streamFunctionHelper();
    return _stream;
  }

  @override
  void initState() {
    super.initState();
    _getUpdatedStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        title: Text(
          'Post Videos',
          style: TextStyle(color: ColorConstants.blackColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder(
              stream: _getUpdatedStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error 404\nData not Found'),
                  );
                } else {
                  if (snapshot.data?.docs != null) {
                    reviewList.clear();
                    snapshot.data.docs.forEach((doc) {
                      reviewList.add(Review.fromDocument(doc));
                    });
                  }
                  return (snapshot.hasData)
                      ? (reviewList.length == 0)
                          ? Center(
                              child: Text('No data found'),
                            )
                          : GridView.builder(
                              padding: EdgeInsets.all(16),
                              itemCount: reviewList.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return ReviewVideoCardWidget(
                                  review: reviewList[index],
                                );
                              })
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
