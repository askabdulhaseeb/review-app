import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'users_firebase_methods.dart';
import '../services/user_local_data.dart';
import '../widgets/show_toast_messages.dart';
import '../model/model_helpers.dart/app_user_model_helper.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() {
    return _auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);

      if (result != null) {
        User user = result.user;
        var _isUserExist =
            await UsersFirebaseMethods().isUserExist(uid: user.uid);
        if (!_isUserExist) {
          await UsersFirebaseMethods().addUser(
            uid: user.uid,
            userInfoMap: UsersFirebaseMethods().userToMap(user: user),
          );
        }
        UserLocalData.setUID(user.uid);
        UserLocalData.setDisplayName(user.displayName);
        UserLocalData.setEmail(user.email);
        UserLocalData.setImageURL(user.photoURL);
        UserLocalData.setPhoneNumber(user.phoneNumber);
        return user;
      }
    } catch (e) {
      showErrorToast(e.toString());
      return null;
    }
    return null;
  }

  Future<User> loginFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    if (result.status != FacebookLoginStatus.loggedIn) {
      showErrorToast('Something goes wrong');
      return null;
    } else {
      User _user = await FirebaseAuth.instance
          .signInWithCredential(
              FacebookAuthProvider.credential(result.accessToken.token))
          .then((UserCredential authResult) async {
        final user = authResult.user;
        final Map<String, dynamic> userInfoMap = {
          mhUID: user.uid,
          mhEMAIL: user.email ?? '',
          mhFIRSTNAME: user.displayName ?? '',
          mhLASTNAME: '',
          mhIMAGEURL: user.photoURL ?? '',
        };
        await UsersFirebaseMethods()
            .addUser(uid: user.uid, userInfoMap: userInfoMap);
        UserLocalData.setUID(user.uid);
        UserLocalData.setDisplayName(user.displayName);
        UserLocalData.setEmail(user.email);
        UserLocalData.setImageURL(user.photoURL);
        return user;
      });
      return _user;
    }
  }

  Future<User> signinWithPhoneNumber(
      String verificationCode, String pin) async {
    try {
      var _userr = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: pin))
          .then((value) async {
        print('In Auth Phone');
        if (value.user != null) {
          print('case user not null');
          var _isUserExist =
              await UsersFirebaseMethods().isUserExist(uid: value.user.uid);
          print('case goes fine');
          if (!_isUserExist) {
            print('case user is new');
            UsersFirebaseMethods().addUser(
              uid: value.user.uid,
              userInfoMap: UsersFirebaseMethods().userToMap(user: value.user),
            );
            print('case end successful');
          }
          UserLocalData.setUID(value.user.uid);
          UserLocalData.setPhoneNumber(value.user.phoneNumber);
          print('case return user: ${value.user.uid}');
          return value.user;
        }
      });
      return _userr;
    } catch (e) {
      showErrorToast('Invalid OTP');
      return null;
    }
  }

  Future signOut() async {
    UserLocalData.signout();
    await _auth.signOut();
  }
}
