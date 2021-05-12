import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../database/auth_methods.dart';
import '../../../database/users_firebase_methods.dart';
import '../../../screens/category/category_screen.dart';
import '../../../screens/gender/gender_screen.dart';
import '../../../utils/color_constants.dart';

class LoginWithFacebook extends StatefulWidget {
  const LoginWithFacebook({
    Key key,
  }) : super(key: key);

  @override
  _LoginWithFacebookState createState() => _LoginWithFacebookState();
}

class _LoginWithFacebookState extends State<LoginWithFacebook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          User _user = await AuthMethods().loginFacebook();
          if (_user != null) {
            print('login FB case: user not null');
            var gender =
                await UsersFirebaseMethods().getUserGender(uid: _user.uid);
            if (gender == '' || gender == null) {
              print('login FB case: user is new');
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => GenderScreen()),
              );
            } else {
              print('login FB case: user is old');
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => ColorConstants.continueWithFbButtonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(width: 2.0, color: ColorConstants.primaryColor),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FaIcon(
              FontAwesomeIcons.facebook,
              color: ColorConstants.whiteColor,
            ),
            Expanded(
              child: Text(
                'Continue with Facebook',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  color: ColorConstants.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
