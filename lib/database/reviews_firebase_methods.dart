import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:reviewapp/widgets/show_toast_messages.dart';
import '../utils/firebase_strings.dart';

class ReviewsFirebaseMethods {
  getAllReviews() async {
    return FirebaseFirestore.instance.collection(fReviews).snapshots();
  }

  getAllReviewsOfSpecificCategory({@required String categoryID}) async {
    return FirebaseFirestore.instance
        .collection(fReviews)
        .where('categoryId', isEqualTo: categoryID)
        .snapshots();
  }

  getSpecificReviewByID({@required String reviewID}) async {
    return FirebaseFirestore.instance.collection(fReviews).doc(reviewID).get();
  }

  getAllReviewByID({@required String uid}) async {
    return FirebaseFirestore.instance
        .collection(fReviews)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  storeVideoToFirestore(File image) async {
    try {
      final ref = FirebaseStorage.instance.ref(
          'reviews/${DateTime.now().millisecondsSinceEpoch.toString() + basename(image.path)}');

      var task = ref.putFile(image);
      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      return urlDownload;
    } on FirebaseException catch (e) {
      showErrorToast(e.toString());
      return null;
    }
  }

  addNewReview(Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection(fReviews)
        .add(map)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection(fReviews)
          .doc(value.id)
          .update({'reviewID': value.id});
    });
  }

  updateReview(
      {@required String reviewID, @required Map<String, dynamic> map}) async {
    await FirebaseFirestore.instance
        .collection(fReviews)
        .doc(reviewID)
        .update(map);
  }
}
