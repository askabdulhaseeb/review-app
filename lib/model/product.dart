import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/assets_images.dart';

class Product {
  String id;
  String title;
  double price;
  String category;
  String subCategory;
  String secondSubCategory;
  String description;
  String image;
  double rating;
  int votes;
  int like;

  Product({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.category,
    @required this.subCategory,
    @required this.secondSubCategory,
    this.description,
    this.image = defaultImageUrl,
    this.rating = 5.0,
    this.votes = 0,
    this.like = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? '',
      'title': title ?? '',
      'price': price ?? 0.0,
      'category': category ?? '',
      'sub_category': subCategory ?? '',
      'second_sub_category': secondSubCategory ?? '',
      'description': description ?? '',
      'imageURL': image ?? '',
      'rating': rating,
      'votes': votes,
      'like': like,
    };
  }

  factory Product.fromDocument(doc) {
    return Product(
      id: doc.data()['id'] ?? '',
      title: doc.data()['title'] ?? '',
      price: doc.data()['price'] ?? 0.0,
      category: doc.data()['category'] ?? '',
      subCategory: doc.data()['sub_category'] ?? '',
      secondSubCategory: doc.data()['second_sub_category'] ?? '',
      description: doc.data()['description'] ?? '',
      image: doc.data()['imageURL'] ?? '',
      rating: doc.data()['rating'] as double,
      votes: doc.data()['votes'] as int,
      like: doc.data()['like'] as int,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      price: map['price'] as double ?? 0.0,
      category: map['category'] ?? '',
      subCategory: map['sub_category'] ?? '',
      secondSubCategory: map['second_sub_category'] ?? '',
      description: map['description'] ?? '',
      image: map['imageURL'] ?? '',
      rating: map['rating'] as double,
      votes: map['votes'] as int,
      like: map['like'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
