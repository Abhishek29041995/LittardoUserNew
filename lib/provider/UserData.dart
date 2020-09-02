import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:littardo/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier {
  Map _userData;
  String token = "";
  String cartCount = "";
  List featured = new List();
  List bannerOffers = new List();
  List<Widget> bannerOffersWidget = new List();
  List bestselling = new List();
  List hot_deals = new List();
  List brands = new List();
  List categories = new List();
  List banners = new List();
  get userData => _userData;

  get getfeatured => featured;
  get getbannerOffers => bannerOffers;
  get getBannersWidgets => bannerOffersWidget;
  get getbestselling => bestselling;
  get gethot_deals => hot_deals;
  get getbrands => brands;
  get getcategories => categories;
  get getbanners => banners;

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
    getDashBoardData();
    notifyListeners();
  }

  Future<void> saveCartCount(int length) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cartCount", length.toString());
    cartCount = length.toString();
    notifyListeners();
  }

  void getDashBoardData() {
    commeonMethod2(api_url + "home", userData['api_token']).then((onResponse) {
      Map data = json.decode(onResponse.body);
      if (data['code'] == 200) {
        bannerOffers = data['data']['offer_banner'];
        featured = data['data']['featured'];
        categories = data['data']['categories'];
        banners = data['data']['banners'];
        bestselling = data['data']['best_selling'];
        hot_deals = data['data']['hot_deals'];
        brands = data['data']['brands'];
        buildBanner();
        notifyListeners();
      }
    }).catchError((onerr) {});
  }

  void buildBanner() {
    bannerOffers.forEach((element) {
      bannerOffersWidget.add(Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Image.network(
            element["photo"],
            fit: BoxFit.cover,
            width: 1000.0,
          ),
        ),
      ));
    });
    notifyListeners();
  }
}
