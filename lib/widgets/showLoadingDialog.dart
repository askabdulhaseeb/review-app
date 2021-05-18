import 'package:flutter/material.dart';

// show the loding circular progress indecator to the user
showLoadingDislog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
