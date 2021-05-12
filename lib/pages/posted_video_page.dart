import 'package:flutter/material.dart';
import '../model/review_video.dart';
import '../utils/color_constants.dart';

class PostedVideoPage extends StatefulWidget {
  @override
  _PostedVideoPageState createState() => _PostedVideoPageState();
}

class _PostedVideoPageState extends State<PostedVideoPage> {
  List<ReviewVideo> _reviewVideosList = [];

  @override
  void initState() {
    getReviewVideos();
    super.initState();
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
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _reviewVideosList.length,
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(_reviewVideosList[index].image),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _reviewVideosList[index].title,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstants.whiteColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'view',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorConstants.whiteColor),
                                  ),
                                  Text(
                                    _reviewVideosList[index].views,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorConstants.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  getReviewVideos() {
    _reviewVideosList.add(
      ReviewVideo('https://picsum.photos/200/300', 'title of review', '1225'),
    );

    _reviewVideosList.add(
      ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
    );

    _reviewVideosList.add(
      ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
    );

    _reviewVideosList.add(
      ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
    );

    _reviewVideosList.add(
      ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
    );

    _reviewVideosList.add(
      ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
    );

    _reviewVideosList.add(
      ReviewVideo('https://picsum.photos/200/300', 'title of review', '125'),
    );
  }
}
