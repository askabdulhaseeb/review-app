import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSuccessToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.green,
    timeInSecForIosWeb: 3,
  );
}

void showErrorToast(String error) {
  Fluttertoast.showToast(
    msg: error,
    backgroundColor: Colors.red,
    timeInSecForIosWeb: 15,
  );
}
