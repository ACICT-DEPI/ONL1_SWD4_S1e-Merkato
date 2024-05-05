import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = "USERKEY";

  static String userNameKey = "USERNAMEKEY";

  static String userEmailKey = "USEREMAILKEY";

  static String userPhoneKey = "USERPHONEKEY";
  static String userWalletKey = "USERWALLETKEY";
  static String userProfileKey = "USEPROFILEKEY";


////////// save athe keys\\\\\\\
///////// saveUserId\\\\\\\\\\\\
  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }
///////////////saveUserName\\\\\\\\\\\\\\
  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }
//////////////// saveUserEmail\\\\\\\\\\\\\\\\\\\
  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(userEmailKey, getUserEmail);
  }
  ///////////////saveUserPhone number\\\\\\\\\\\\\\
  Future<bool> saveUserPhone(String getUserPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userPhoneKey, getUserPhone);
  }
/////////////////saveUserWallet\\\\\\\\\\\\\\\\\\\
  Future<bool> saveUserWallet(String getUserWallet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(userWalletKey, getUserWallet);
  }
 ///////////// saveUserProfile\\\\\\\\\\\\\\\\\
   Future<bool> saveUserProfile(String getUserProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(userProfileKey, getUserProfile );
  }

  ///////////////////////gets\\\\\\\\\\\\\\
  ///\\\\\\\\\\\\\\\\\\\////\/\/\//\\/\\/
////////////////getUserId\\\\\\\\\\\\\\\\
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }
 /////////////////  getUserName\\\\\\\\\\\\\\
    Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }
 /////////////////// getUserEmail\\\\\\\\\\\\\\\\\\
    Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
  /////////////////// getUserPhone\\\\\\\\\\\\\\\\\\
    Future<String?> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoneKey);
  }
  ////////////////////getUserWallet\\\\\\\\\\\
    Future<String?> getUserWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userWalletKey);
  }
  /////////////////getUserProfile\\\\\\\\\\\\\\\\\
    Future<String?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfileKey);
  }


}