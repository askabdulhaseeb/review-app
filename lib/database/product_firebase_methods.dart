import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reviewapp/widgets/show_toast_messages.dart';
import '../utils/firebase_strings.dart';
import 'package:path/path.dart';

class ProductFirebaseMethods {
  storeImageToFirestore(File image) async {
    try {
      final ref = FirebaseStorage.instance.ref(
          'product/${DateTime.now().millisecondsSinceEpoch.toString() + basename(image.path)}');

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

  getSnapshotOfSearchedProduct(String find) async {
    return FirebaseFirestore.instance
        .collection(fProducts)
        .where('title', isGreaterThanOrEqualTo: find.toUpperCase())
        .snapshots();
  }

  addNewProduct({@required Map<String, dynamic> productInfo}) async {
    await FirebaseFirestore.instance
        .collection(fProducts)
        .add(productInfo)
        .then(
      (value) async {
        await FirebaseFirestore.instance
            .collection(fProducts)
            .doc(value.id)
            .update({'id': value.id});
      },
    );
  }

  fetchProductInfo({@required id}) async {
    return await FirebaseFirestore.instance.collection(fProducts).doc(id).get();
  }
}
