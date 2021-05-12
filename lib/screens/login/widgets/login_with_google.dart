import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../database/auth_methods.dart';
import '../../../database/users_firebase_methods.dart';
import '../../../screens/category/category_screen.dart';
import '../../../screens/gender/gender_screen.dart';
import '../../../utils/assets_images.dart';
import '../../../utils/color_constants.dart';

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          User _user = await AuthMethods().signInWithGoogle(context);
          if (_user != null) {
            final String gender =
                await UsersFirebaseMethods().getUserGender(uid: _user.uid);
            if (gender.isEmpty || gender == '' || gender == null) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => GenderScreen()),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => ColorConstants.bgColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(width: 2.0, color: ColorConstants.primaryColor),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              iGoogleLogo,
              width: 24,
              height: 24,
            ),
            Expanded(
              child: Text(
                'Continue with Google',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
