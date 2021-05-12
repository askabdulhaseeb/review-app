import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import '../../database/users_firebase_methods.dart';
import '../../model/category.dart';
import '../../model/model_helpers.dart/app_user_model_helper.dart';
import '../../model/model_helpers.dart/categories_model_helper.dart';
import '../../screens/home/home_screen.dart';
import '../../services/user_local_data.dart';
import '../../utils/color_constants.dart';

import 'selectable_category_image_widget.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> categoriesList = [];
  List<Map<String, String>> favListMap = [];

  final controller = DragSelectGridViewController();
  int miniSelection = 5;
  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCategoriesList();
    UserLocalData.setUID('yiqovE9jlwUQ7LzoGQc53lVIMjk1');
    controller.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  void scheduleRebuild() => setState(() {});

  onClick(int index, bool isSelected) {
    if (isSelected == true) {
      favListMap.add({
        cmhID: categoriesList[index].id,
        cmhCATEGORIESNAME: categoriesList[index].title,
      });
    } else {
      favListMap.removeWhere(
          (element) => element.containsValue(categoriesList[index].id));
    }
    // favListMap.sort();
    print('Updated Map: $favListMap');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome to \nMYREVUE app',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  //next button
                  (miniSelection - controller.value.amount > 0)
                      ? Container()
                      : InkWell(
                          onTap: () async {
                            favListMap.sort(
                              (a, b) => a[cmhCATEGORIESNAME].compareTo(
                                b[cmhCATEGORIESNAME],
                              ),
                            );
                            await UsersFirebaseMethods().updateUser(
                                uid: UserLocalData.getUID(),
                                userInfoMap: {
                                  mhUSER_FAC_CAT: favListMap,
                                });
                            await UsersFirebaseMethods().updateUserLocalData(
                              uid: UserLocalData.getUID(),
                            );
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: ColorConstants.greenColor,
                                border: Border.all(
                                    color: ColorConstants.containerBgColor),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.0),
                                )),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                ((5 - controller.value.amount) <= 0)
                    ? 'You select categories\nYour are good to go now'
                    : 'Pick atleast ${5 - controller.value.amount} categories to get started',
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                ),
              ),
              Center(
                child: Text(
                  'Long Press or Long press and drag to select',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: DragSelectGridView(
                  gridController: controller,
                  padding: EdgeInsets.all(8),
                  itemCount: categoriesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index, isSelected) =>
                      SelectableCategoryImageWidget(
                    index: index,
                    imageURL: categoriesList[index].image,
                    name: categoriesList[index].title,
                    isSelected: isSelected,
                    onClick: onClick,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCategoriesList() async {
    categoriesList = [];
    await fireStoreInstance
        .collection("categories")
        .orderBy("category_name", descending: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Category obj;
        obj = Category(
            image: result['image'],
            isSelected: false,
            title: result['category_name'],
            id: result['id']);
        categoriesList.add(obj);
      });
    });
    setState(() {});
  }
}
