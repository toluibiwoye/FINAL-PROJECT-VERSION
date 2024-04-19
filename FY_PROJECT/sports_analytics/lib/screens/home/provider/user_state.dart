import 'package:flutter/material.dart';

import '../../../utils/reg_response.dart';
import '../../../utils/user_preferences.dart';

class UserNotifier with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUserDetails() async {
    final userFirstName = await UserPreferences.getUserFirstName();
    final userLastName = await UserPreferences.getUserLastName();
    final userEmail = await UserPreferences.getUserEmail();
    final userId = await UserPreferences.getUserId();
    final userPhone = await UserPreferences.getUserPhone();
    final userRole = await UserPreferences.getUserRole();
    final userToken = await UserPreferences.getUserToken();
    _user = User(firstName: userFirstName ?? "", id: 123, email: userEmail ?? "",
        password: "", role: userRole ?? "", lastName: userLastName ?? "", phoneNumber: userPhone ?? "123",
        createdAt: DateTime.now(), updatedAt: DateTime.now(), );
    notifyListeners();
  }
}