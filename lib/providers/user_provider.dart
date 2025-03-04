import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) async {
    _user = user;
    notifyListeners();
    _saveUserToPrefs(user);
  }

  void _saveUserToPrefs(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', user.uid);
    await prefs.setString('name', user.name);
    await prefs.setString('email', user.email);
    await prefs.setString('role', user.role);
  }

  Future<void> loadUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? role = prefs.getString('role');

    if (uid != null && name != null && email != null && role != null) {
      _user = UserModel(uid: uid, name: name, email: email, role: role);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _user = null;
    notifyListeners();
  }
}
