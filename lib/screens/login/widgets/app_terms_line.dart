import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../screens/privacy_policy/privacy_policy_screen.dart';
import '../../../screens/terms_of_service/terms_of_service_screen.dart';
import '../../../utils/color_constants.dart';

class AppTermsLineOfLoginScreen extends StatelessWidget {
  const AppTermsLineOfLoginScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By continuing, you agree to MYREVUE\'s ',
          style: TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.normal),
          children: <TextSpan>[
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: ColorConstants.linkColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // navigate to terms of service screen
                  print('terms of service clicked');

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TermsOfServiceScreen(),
                    ),
                  );
                },
            ),
            TextSpan(
                text: ' and ',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Quicksand',
                    fontSize: 14,
                    fontWeight: FontWeight.normal)),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: ColorConstants.linkColor,
                fontFamily: 'Quicksand',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // navigate to terms of privacy policy screen
                  print('privacy policy clicked');

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen(),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
