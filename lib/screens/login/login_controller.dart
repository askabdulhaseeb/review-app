import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../screens/login/profile_model.dart';

enum ACCOUNT { google, facebook }

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;

  Profile profile;
  ACCOUNT accountType;
  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      var result = await auth.signInWithCredential(credential);
      print(result);
      User currentuser = auth.currentUser;
      profile = Profile(
        name: currentuser.displayName,
        email: currentuser.email,
        image: currentuser.photoURL,
        id: currentuser.uid,
      );
      print("..............");
      print(profile.email);
      accountType = ACCOUNT.google;
      return true;
    } else {
      print('................. in else .........................');
      return false;
    }
  }

  Future<bool> signOutUser() async {
    if (accountType == ACCOUNT.google) {
      await googleSignIn.disconnect();
      return true;
    } else if (accountType == ACCOUNT.facebook) {
      await facebookSignIn.logOut();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print(accessToken);

        final myResult = await facebookSignIn.logIn(['email']);
        final token = myResult.accessToken.token;

        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture.width(800).height(800),email&access_token=$token'));
        final profileDecoded = convert.jsonDecode(graphResponse.body);

        profile = Profile(
            email: profileDecoded['email'],
            name: profileDecoded['name'],
            id: profileDecoded['id'],
            image: profileDecoded['picture']['data']['url']);
        accountType = ACCOUNT.facebook;
        return true;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        return false;
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        return false;
        break;
      default:
        return false;
    }
  }
}
