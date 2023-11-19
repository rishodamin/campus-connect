import 'package:campus_connect/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as model;
//import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  model.User? user;
  final AuthMethods _authmethods = AuthMethods();

  model.User? get getUser => user;

  Future<void> refreshUser() async {
    user = await _authmethods.getUserDetails();
    notifyListeners();
  }
}
