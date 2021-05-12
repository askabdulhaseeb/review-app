// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart';

// import 'package:firebase_storage/firebase_storage.dart';
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
    getReviewVideos();
    _getUpdatedStream();
  }

  // UploadTask task;
  // File file;
  // String fileName;
  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  //   if (result == null) return;
  //   final path = result.files.single.path;

  //   setState(() => file = File(path));
  //   fileName = (file != null) ? basename(file.path) : 'No File Selected';
  //   uploadFile();
  // }

  // Future uploadFile() async {
  //   if (file == null) return;

  //   final fileName = basename(file.path);
  //   final destination = 'files/$fileName';

  //   task = UploadVideoFirebase.uploadFile(destination, file);
  //   setState(() {});

  //   if (task == null) return;

  //   final snapshot = await task.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();

  //   print('Download-Link: $urlDownload');
  // }

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
              VideoWidget(
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
              // Flexible(
              // child: ReviewVideoCardWidget(
              //   url:
              //       'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
              // ),
              //   child: ,
              // child: StreamBuilder(
              //   stream: _getUpdatedStream(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Center(
              //         child: Text('Error 404\nData not Found'),
              //       );
              //     } else {
              //       return (snapshot.hasData)
              //           ? GridView.builder(
              //               padding: EdgeInsets.all(16),
              //               itemCount: snapshot.data.docs.length,
              //               shrinkWrap: true,
              //               primary: false,
              //               gridDelegate:
              //                   SliverGridDelegateWithFixedCrossAxisCount(
              //                       crossAxisCount: 2,
              //                       crossAxisSpacing: 8,
              //                       mainAxisSpacing: 8,
              //                       childAspectRatio: 0.7),
              //               itemBuilder: (BuildContext context, int index) {
              //                 DocumentSnapshot ds = snapshot.data.docs[index];
              //                 return ReviewVideoCardWidget(
              //                   // url: ds['url'] ?? '',
              //                   url:
              //                       'https://www.youtube.com/watch?v=aqHkkQCKpxE',
              // reviewID: ds['review_id'] ?? '',
              // title: ds['title'] ?? 'No Title',
              // views: ds['views'] ?? '0' as int,
              // );
              // Chewie
              // youtube_player_flutter
              //               },
              //             )
              //           : Center(
              //               child: Text('No Data found yet'),
              //             );
              //     }
              //   },
              // ),
              // ),
            ],
          );
        },
      )),
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
