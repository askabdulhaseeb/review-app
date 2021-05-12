import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData {
  static SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static signout() => _preferences.clear();

  static String _uidKey = 'UIDKEY';
  static String _displayNameKey = 'DISPLAYNAMEKEY';
  static String _imageURL = 'IMAGEURLKEY';
  static String _emailKey = 'EMAILKEY';
  static String _phoneNumberKey = 'PHONENUMBERKEY';
  static String _catNameFavListKey = 'CAT_NAME_FAV_LIST';
  static String _catIdFavListKey = 'CAT_ID_FAV_LIST';

  //
  // setter
  //
  static Future setUID(String uid) async =>
      await _preferences.setString(_uidKey, uid ?? '');
  static Future setDisplayName(String displayName) async =>
      await _preferences.setString(_displayNameKey, displayName ?? '');
  static Future setImageURL(String imageURL) async =>
      await _preferences.setString(_imageURL, imageURL ?? '');
  static Future setEmail(String email) async =>
      await _preferences.setString(_emailKey, email ?? '');
  static Future setPhoneNumber(String phoneNumber) async =>
      await _preferences.setString(_phoneNumberKey, phoneNumber ?? '');
  static Future setNameOfFavCategoriesList(List<String> list) async =>
      await _preferences.setStringList(_catNameFavListKey, list);
  static Future setIdOfFavCategoriesList(List<String> list) async =>
      await _preferences.setStringList(_catIdFavListKey, list);

  //
  // getter
  //
  static String getUID() => _preferences.getString(_uidKey) ?? '';
  static String getDisplayName() =>
      _preferences.getString(_displayNameKey) ?? '';
  static String getImageURL() => _preferences.getString(_imageURL) ?? '';
  static String getEmail() => _preferences.getString(_emailKey) ?? '';
  static String getPhoneNumber() =>
      _preferences.getString(_phoneNumberKey) ?? '';
  static List<String> getNameOfFavCategoriesList() =>
      _preferences.getStringList(_catNameFavListKey ?? []);
  static List<String> getIdOfFavCategoriesList() =>
      _preferences.getStringList(_catIdFavListKey ?? []);
}
