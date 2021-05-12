import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/sub_category.dart';
import '../../screens/product_search/product_search_screen.dart';
import '../../utils/color_constants.dart';

class SubCategoryScreen extends StatefulWidget {
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  List<SubCategory> subCategoriesList = [];

  @override
  void initState() {
    getSubCategoriesList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  //header
                  Stack(
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://picsum.photos/seed/picsum/200/300',
                            width: double.maxFinite,
                            height: 220,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 220,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),

                      //appbar row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: ColorConstants.whiteColor,
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Fashion',
                            style: TextStyle(
                                color: ColorConstants.whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          IconButton(
                            color: ColorConstants.whiteColor,
                            icon: Icon(Icons.search),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  //sub-categories
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: subCategoriesList.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductSearchScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16),
                          child: Row(
                            children: [
                              // Icon(subCategoriesList[index].icon),
                              SizedBox(width: 16),
                              Text(subCategoriesList[index].title),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getSubCategoriesList() {
    // subCategoriesList.add(SubCategory(Icons.camera_rounded, 'Bikes'));
    // subCategoriesList.add(SubCategory(Icons.category, 'Car and SUVx'));
    // subCategoriesList.add(SubCategory(Icons.keyboard, 'Car Dealers'));
    // subCategoriesList.add(SubCategory(Icons.electric_bike, 'Bike Dealers'));
    // subCategoriesList.add(SubCategory(Icons.auto_fix_high, 'Automotive Websites'));
  }
}
