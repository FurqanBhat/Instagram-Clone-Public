import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
class UserProvider with ChangeNotifier{
  User? _user;
  User get getUser => _user!;
  AuthMethods _authMethods= AuthMethods();
  UserProvider(){
    refreshUser();
  }
  Future<void> refreshUser() async{
    _user =await _authMethods.getUserDetails();
    notifyListeners();

  }

}