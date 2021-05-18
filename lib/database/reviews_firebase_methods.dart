import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../utils/firebase_strings.dart';

class ReviewsFirebaseMethods {
  getAllReviewsOfSpecificCategory({@required String categoryID}) async {
    var datee = await FirebaseFirestore.instance
        .collection(fReviews)
        .where('category_id', isEqualTo: categoryID)
        .snapshots();
    return datee;
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
}
