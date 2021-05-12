import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/firebase_strings.dart';

class ProductFirebaseMethods {
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
}
