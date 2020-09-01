import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier {
  Map _userData;
  String token = "";
  String cartCount = "";

  get userData => _userData;

  get getToken => token;

  UserData() {
    getLoggedInData();
  }

  Future<Null> storeLoginData(Map data, int cartcount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', 'loggedIn');
    prefs.setString(
        "cartCount", cartcount != null ? cartcount.toString() : "0");
    prefs.setString('user', json.encode(data));
    getLoggedInData();
  }

  Future<void> getLoggedInData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userData = jsonDecode(prefs.getString("user"));
    token = "loggedIn";
    if (prefs.getString("cartCount") == null) {
      prefs.setString("cartCount", _userData['cart_count']);
      cartCount =
          _userData['cart_count'] != null ? _userData['cart_count'] : "0";
    } else {
      cartCount = prefs.getString("cartCount");
    }
    notifyListeners();
  }

  Future<void> saveCartCount(int length) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cartCount", length.toString());
    cartCount = length.toString();
    notifyListeners();
  }
}
