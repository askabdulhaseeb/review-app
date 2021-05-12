import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/app_user.dart';
import '../model/model_helpers.dart/app_user_model_helper.dart';
import '../model/model_helpers.dart/categories_model_helper.dart';
import '../services/user_local_data.dart';
import '../utils/firebase_strings.dart';
import '../widgets/show_toast_messages.dart';

class UsersFirebaseMethods {
  Future addUser({
    @required String uid,
    @required Map<String, dynamic> userInfoMap,
  }) async {
    return await FirebaseFirestore.instance
        .collection(fUser)
        .doc(uid)
        .set(userInfoMap)
        .catchError((error) {
      showErrorToast(error);
    });
  }

  Future updateUser({
    @required String uid,
    @required Map<String, dynamic> userInfoMap,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(fUser)
          .doc(uid)
          .update(userInfoMap)
          .catchError((error) {
        showErrorToast(error);
      });
      updateUserLocalData(uid: uid);
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  Future getUserInfo({@required String uid}) async {
    return await FirebaseFirestore.instance.collection(fUser).doc(uid).get();
  }

  Future getUserGender({@required String uid}) async {
    return await FirebaseFirestore.instance
        .collection(fUser)
        .doc(uid)
        .get()
        .then(
      (value) {
        return value.data()[mhGENDER];
      },
    );
  }

  Future isUserExist({@required String uid}) async {
    return await FirebaseFirestore.instance
        .collection(fUser)
        .doc(uid)
        .get()
        .then(
          (value) => value.exists,
        );
  }

  Map<String, dynamic> userToMap({@required User user}) {
    return {
      mhUID: user.uid,
      mhFIRSTNAME: user.displayName ?? '',
      mhLASTNAME: '',
      mhEMAIL: user.email ?? '',
      mhIMAGEURL: user.photoURL ?? '',
      mhPHONE: user.phoneNumber ?? '',
    };
  }

  Future<AppUser> getUserObject({@required String uid}) async {
    return FirebaseFirestore.instance.collection(fUser).doc(uid).get().then(
          (user) => AppUser.fromMap(
            user.data(),
          ),
        );
  }

  void storeUserDateInLocal({@required AppUser user}) {
    UserLocalData.setUID(user.getUID);
    UserLocalData.setDisplayName(user.getDisplayName);
    UserLocalData.setImageURL(user.getImageURL);
    UserLocalData.setEmail(user.getEmail);
    UserLocalData.setPhoneNumber(user.getPhoneNumber);
  }

  Future updateUserLocalData({@required String uid}) async {
    await FirebaseFirestore.instance.collection(fUser).doc(uid).get().then(
      (value) {
        UserLocalData.setDisplayName(
          (value.data()[mhFIRSTNAME] ??
                  '' + ' ' + value.data()[mhLASTNAME] ??
                  '')
              .toString()
              .trim(),
        );
        UserLocalData.setImageURL(
            value.data()[mhIMAGEURL].toString().trim() ?? '');
        UserLocalData.setEmail(value.data()[mhEMAIL].toString().trim() ?? '');
        UserLocalData.setPhoneNumber(
            value.data()[mhPHONE].toString().trim() ?? '');

        List<Map<String, dynamic>> _list =
            List<Map<String, dynamic>>.from(value.data()[mhUSER_FAC_CAT] ?? []);

        List<String> _catNameList = [];
        List<String> _catIdList = [];
        for (int i = 0; i < _list.length; i++) {
          _catNameList.add(
              value.data()[mhUSER_FAC_CAT][i][cmhCATEGORIESNAME] as String);
          _catIdList.add(value.data()[mhUSER_FAC_CAT][i][cmhID] as String);
        }
        UserLocalData.setNameOfFavCategoriesList(_catNameList);
        UserLocalData.setIdOfFavCategoriesList(_catIdList);
      },
    );
  }

  Future getUserSpecificData({@required String item}) async {
    return await FirebaseFirestore.instance
        .collection(fUser)
        .doc(UserLocalData.getUID())
        .get()
        .then((value) => value.data()[item]);
  }
}
