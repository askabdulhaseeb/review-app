// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../database/reviews_firebase_methods.dart';
// import 'package:review_app/database/video_uploade_firebase.dart';
import '../../pages/AllCategories/custome_tab_bar_view.dart';
// import 'package:review_app/pages/videoOfFirebasse/video.dart';
// import 'package:review_app/screens/sub_category/sub_category_screen.dart';
import 'adds_carouse_slider.dart';
import '../../model/review_video.dart';
import '../../screens/search/search_screen.dart';
import '../../services/user_local_data.dart';
import '../../utils/color_constants.dart';
import 'review_video_gridview_card.dart';
import 'video_widget.dart';

class AllCategoriesPage extends StatefulWidget {
  @override
  _AllCategoriesPageState createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage>
    with SingleTickerProviderStateMixin {
  List<ReviewVideo> _reviewVideosList = [];
  List<String> _tabsName = [];
  List<String> _facCatId = [];
  int _initPosition = 1;
  int ind;
  Stream _stream;

  getTabs() {
    _tabsName = UserLocalData.getNameOfFavCategoriesList();
    _tabsName.insert(0, 'Leader Board');
    _facCatId = UserLocalData.getIdOfFavCategoriesList();
  }

  _streamFunctionHelper(int index) async {
    print('Possition: ${_facCatId[_initPosition - 1]}');
    _stream = await ReviewsFirebaseMethods().getAllReviewsOfSpecificCategory(
      categoryID: _facCatId[_initPosition - 1],
    );
    setState(() {});
  }

  _getUpdatedStream() {
    _streamFunctionHelper(_initPosition);
    return _stream;
  }

  @override
  void initState() {
    getTabs();
    super.initState();
    _initPosition = 1;
    _getUpdatedStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('MYREVUE App',
            style: TextStyle(color: ColorConstants.blackColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: ColorConstants.blackColor),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomTabView(
          initPosition: _initPosition,
          itemCount: _tabsName.length,
          tabBuilder: (context, index) => Tab(text: _tabsName[index]),
          onPositionChange: (value) {
            setState(() {
              _initPosition = value;
            });
          },
          pageBuilder: (context, index) {
            return Column(
              children: [
                AddsCarouseSlider(),
                // VideoWidget(
                //     'https://firebasestorage.googleapis.com/v0/b/myrevue-a3152.appspot.com/o/reviews%2F1621364387503b050a018-7729-4ce7-931c-493d2ede3bf63592458739462634040.mp4?alt=media&token=e08058bc-bbbb-4ec9-92a5-39bf1763f400'),
                // Flexible(
                // ReviewVideoCardWidget(
                //   url:
                //       'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                // ),
                StreamBuilder(
                  stream: _getUpdatedStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error 404\nData not Found'),
                      );
                    } else {
                      print('Length: ${snapshot?.data?.docs?.length}');
                      return (snapshot.hasData)
                          ? GridView.builder(
                              padding: EdgeInsets.all(16),
                              itemCount: snapshot?.data?.docs?.length,
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
                                if (snapshot?.data?.docs[index] != null) {
                                  DocumentSnapshot ds =
                                      snapshot?.data?.docs[index];
                                  return ReviewVideoCardWidget(
                                    // url: ds['url'] ?? '',
                                    url: ds['videoURL'],
                                    reviewID: ds['reviewID'] ?? '',
                                    title: ds['title'] ?? 'No Title',
                                    views: int.parse(ds['views'].toString()),
                                  );
                                } else {
                                  return Center(
                                    child: Text('No data found'),
                                  );
                                }
                              })
                          : Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                    }
                    // ),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
