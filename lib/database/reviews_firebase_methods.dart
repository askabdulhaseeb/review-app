import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/firebase_strings.dart';

class ReviewsFirebaseMethods {
  getAllReviewsOfSpecificCategory({@required String categoryID}) async {
    var datee = await FirebaseFirestore.instance
        .collection(fReviews)
        .where('category_id', isEqualTo: categoryID)
        .snapshots();
    return datee;
  }
}
