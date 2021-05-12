import 'package:flutter/material.dart';

class SubCategory {
  String title;
  String id;
  String catId;

  SubCategory({this.id, this.title, this.catId});

  factory SubCategory.fromDocument(doc) {
    return SubCategory(
      id: doc.data()['sub_category_id'] ?? '',
      title: doc.data()['sub_category_name'] ?? '',
      catId: doc.data()['category_id'] ?? '',
    );
  }
}
