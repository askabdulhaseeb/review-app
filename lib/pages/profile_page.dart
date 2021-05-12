import 'package:flutter/material.dart';
import '../database/auth_methods.dart';
import '../screens/edit_profile/edit_profile_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/privacy_policy/privacy_policy_screen.dart';
import '../screens/reset_password/reset_password_screen.dart';
import '../screens/terms_of_service/terms_of_service_screen.dart';
import '../utils/color_constants.dart';
import '../utils/styles.dart';
import '../widgets/user_image_and_info_container.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.bgColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.notifications, color: ColorConstants.blackColor),
          onPressed: () {
            //navigate to notifications screen
          },
        ),
        title: Text('Profile', style: appBarTextStyle),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserImageAndInfoContainer(),
              SizedBox(height: 10),
              _profileRow('Edit Profile', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                );
              }),
              _profileRow('Like and Dislike on your Record Review', () {}),
              _profileRow('Invite Friends', () {}),
              _profileRow('Terms of Service', () {
                //navigate to Terms of Service screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TermsOfServiceScreen(),
                  ),
                );
              }),
              _profileRow('Privacy Policy', () {
                // navigate to terms of privacy policy screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                );
              }),
              _profileRow('Reset Password', () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ResetPasswordScreen(),
                  ),
                );
              }),
              _profileRow('Sign out', () {
                // navigate to terms of privacy policy screen
                AuthMethods().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileRow(String title, VoidCallback callback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            callback();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: normalTextStyle),
                Icon(Icons.keyboard_arrow_right_outlined,
                    color: ColorConstants.iconColor),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          color: ColorConstants.dividerColor,
        ),
      ],
    );
  }
}
