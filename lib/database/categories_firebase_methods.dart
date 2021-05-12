import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/category.dart';
import '../model/sub_category.dart';
import '../utils/firebase_strings.dart';

class CategoriesFirebaseMethods {
  // getCategoriesList() async {
  //   await FirebaseFirestore.instance
  //       .collection("categories")
  //       .orderBy("category_name", descending: false)
  //       .get();
  // }

  getCategoriesList() async {
    List<Category> _cat = [];
    await FirebaseFirestore.instance
        .collection('categories')
        .orderBy("category_name", descending: false)
        .get()
        .then(
      (data) {
        data.docs.forEach((element) {
          if (element != null) {
            _cat.add(
              Category.fromDocument(element),
            );
          }
        });
      },
    );
    return _cat;
  }

  getCategoriesSubCat(String id) async {
    List<SubCategory> _cat = [];
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(id)
        .collection('sub_categories')
        .get()
        .then(
      (data) {
        data.docs.forEach((element) {
          if (element != null) {
            _cat.add(
              SubCategory.fromDocument(element),
            );
          }
        });
      },
    );
    return _cat;
  }
}

// [
//    {
//    cat_id: 123
//    'name': abc
//     sub_cat:[
//        {
//          id: 12
//          name: qw
//        }
//        {
//          id: 1222
//          name: qwsd
//        }
//      ]
//    }
// 
//    {
//    cat_id: 123
//    'name': abc
//     sub_cat:[
//        {
//          id: 12
//          name: qw
//        }
//        {
//          id: 1222
//          name: qwsd
//        }
//      ]
//    }
// ]
