import 'dart:convert';

import 'package:flutter/foundation.dart';

class Review {
  final String uid;
  final String productId;
  final String categoryId;
  final String title;
  final int views;

  Review({
    @required this.uid,
    @required this.productId,
    @required this.categoryId,
    @required this.title,
    @required this.views,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'productId': productId,
      'categoryId': categoryId,
      'title': title,
      'views': views,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      uid: map['uid'],
      productId: map['productId'],
      categoryId: map['categoryId'],
      title: map['title'],
      views: map['views'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
