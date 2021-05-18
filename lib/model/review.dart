import 'dart:convert';

import 'package:flutter/foundation.dart';

class Review {
  final String uid;
  final String reviewID;
  final String productId;
  final String categoryId;
  final String title;
  final String about;
  final double rating;
  final int views;
  final String videoURL;

  Review({
    @required this.uid,
    @required this.reviewID,
    @required this.productId,
    @required this.categoryId,
    @required this.title,
    @required this.about,
    @required this.rating,
    @required this.views,
    @required this.videoURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'reviewID': reviewID,
      'productId': productId,
      'categoryId': categoryId,
      'title': title,
      'about': about,
      'rating': rating,
      'views': views,
      'videoURL': videoURL,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      uid: map['uid'],
      reviewID: map['reviewID'],
      productId: map['productId'],
      categoryId: map['categoryId'],
      title: map['title'],
      about: map['about'],
      rating: map['rating'],
      views: map['views'],
      videoURL: map['videoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
