import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/firebase/auth.dart';
import './../models/user.dart' as model;

class UserProvider with ChangeNotifier {
  model.User? _user;

  model.User? get getUser => _user;

  Future<void> refreshUser() async {
    model.User user = await Auth().getUserDetail();
    print("User is refreshed in the userProvider ..............");
    print(user);
    _user = user;

    notifyListeners();
  }
}
