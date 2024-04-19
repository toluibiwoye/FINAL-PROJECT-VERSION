import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const userIdKey = 'userId';
  static const userTokenKey = 'userToken'; // Corrected key name
  static const userFirstNameKey = 'userFirstName'; // Added Key suffix for consistency
  static const userEmailKey = 'userEmail';
  static const userLastNameKey = 'userLastName'; // Added Key suffix for consistency
  static const userRoleKey = 'userRole';
  static const userPhoneKey = 'userPhone'; // Added Key suffix for consistency
  static const isLoggedInKey = 'isUserLoggedIn';

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<void> setUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userToken);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenKey);
  }

  static Future<void> setUserEmail(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userEmailKey, userEmail);
    debugPrint('Saved successfully $userEmail');
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<void> setUserFirstName(String firstName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userFirstNameKey, firstName);
  }

  static Future<String?> getUserFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userFirstNameKey);
  }

  static Future<void> setUserLastName(String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userLastNameKey, lastName);
  }

  static Future<String?> getUserLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userLastNameKey);
  }

  static Future<void> setUserPhone(String userPhoneNo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPhoneKey, userPhoneNo);
  }

  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoneKey);
  }

  static Future<void> setUserRole(String userRole) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userRoleKey, userRole);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRoleKey);
  }

  static Future<void> setUserLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn); // Corrected to return void
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false; // Defaults to false if not set
  }
}