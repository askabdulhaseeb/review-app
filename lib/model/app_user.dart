import 'dart:convert';
import 'package:flutter/material.dart';

class AppUser {
  final String _uid;
  final String _firstName;
  final String _lastName;
  final String _imageURL;
  final String _email;
  final String _phoneNumber;
  final String _profession;
  final String _gender;
  final String _dateOfBirth;
  final String _address;

  AppUser({
    @required String uid,
    String firstName,
    String lastName,
    String imageURL,
    String email,
    String phoneNumber,
    String profession,
    String gender,
    String dateOfBirth,
    String address,
  })  : _uid = uid,
        _firstName = firstName,
        _lastName = lastName,
        _imageURL = imageURL,
        _email = email,
        _phoneNumber = phoneNumber,
        _profession = profession,
        _gender = gender,
        _dateOfBirth = dateOfBirth,
        _address = address;

  Map<String, dynamic> toMap() {
    return {
      'uid': _uid ?? '',
      'firstName': _firstName ?? '',
      'lastName': _lastName ?? '',
      'imageURL': _imageURL ?? '',
      'email': _email ?? '',
      'phoneNumber': _phoneNumber ?? '',
      'profession': _profession ?? '',
      'gender': _gender ?? '',
      'dateOfBirth': _dateOfBirth ?? '',
      'address': _address ?? '',
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      imageURL: map['imageURL'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profession: map['profession'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  String get getUID => _uid ?? '';
  String get getDisplayName => (_firstName + ' ' + _lastName) ?? '';
  String get getImageURL => _imageURL ?? '';
  String get getEmail => _email ?? '';
  String get getPhoneNumber => _phoneNumber ?? '';
}
