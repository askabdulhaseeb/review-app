import 'package:flutter/material.dart';
import 'package:reviewapp/model/review.dart';
import '../../database/reviews_firebase_methods.dart';
import '../../pages/AllCategories/custome_tab_bar_view.dart';
import 'adds_carouse_slider.dart';
import '../../screens/search/search_screen.dart';
import '../../services/user_local_data.dart';
import '../../utils/color_constants.dart';
import 'review_video_gridview_card.dart';

class AllCategoriesPage extends StatefulWidget {
  @override
  _AllCategoriesPageState createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage>
    with SingleTickerProviderStateMixin {
  List<Review> reviewList = [];
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

  _getReviewObject(String reviewID) async {
    var doc = await ReviewsFirebaseMethods()
        .getSpecificReviewByID(reviewID: reviewID);
    Review review = Review.fromDocument(doc);
    return review;
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
                StreamBuilder(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
              ],
            );
          },
        ),
      ),
    );
  }
}
