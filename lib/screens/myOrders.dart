import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:littardo/orderDetails.dart';
import 'package:littardo/order_review.dart';

//import 'package:littardo/order_review.dart';
import 'package:littardo/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrders createState() => _MyOrders();
}

class _MyOrders extends State<MyOrders> {
  String accessToken = "";
  Map userData;
  List orderListData = new List();
  bool _isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  TextEditingController review = new TextEditingController();
  double ratingValue = 0;

  bool showSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSavedData();
  }

  Future<void> checkSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = jsonDecode(prefs.getString('user'));
    accessToken = userData['api_token'];

    getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blue,
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => {Navigator.of(context).pop()}),
              title: Text(
                "My Orders",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: orderListData.length > 0
                ? SingleChildScrollView(
                    child: Column(
                        children: orderListData.map((item) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => OrderDetais(item)))
                              .then((onVal) {
                            if (onVal == "success") {
                              getMyOrders();
                            }
                          });
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],
                            child: Column(
                              children: <Widget>[
                                Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 8,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
//                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      width: 4,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.yellow[900],
//                                            border: Border(
//                                                bottom: BorderSide(width: 1.0, color: Color(0xffABA6A6)),
//                                                right: BorderSide(width: 1.0, color: Color(0xffABA6A6)))
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.5,
                                                            child: Wrap(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              3,
                                                                          top:
                                                                              10,
                                                                          bottom:
                                                                              10,
                                                                          right:
                                                                              3),
                                                                  child: Text(
                                                                    item['order_details'][0]
                                                                            [
                                                                            'product']
                                                                        [
                                                                        'name'],
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3,
                                                                    bottom: 10),
                                                            child: Text(
                                                              item['order_details']
                                                                          [0][
                                                                      'product']
                                                                  [
                                                                  'description'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3,
                                                                    bottom: 10),
                                                            child: Text(
                                                              "Ordered on - " +
                                                                  item[
                                                                      'created_at'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: ClipRRect(
                                                          child: CachedNetworkImage(
                                                              imageUrl: item['order_details']
                                                                          [0][
                                                                      'product']
                                                                  ['thumbnail_img'],
                                                              height: 120,
                                                              width: 100,
                                                              fit: BoxFit.fill)))),
                                            ],
                                          ),
                                        ),
                                        item['order_details'][0]
                                                    ['delivery_status'] ==
                                                "delivered"
                                            ? Divider()
                                            : SizedBox(),
                                        item['order_details'][0]
                                                    ['delivery_status'] ==
                                                "delivered"
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  children: <Widget>[
                                                    item['order_details'][0]['product'][
                                                                    'user_review'] !=
                                                                null &&
                                                            item['order_details']
                                                                            [0]['product'][
                                                                        'user_review']
                                                                    .length >
                                                                0
                                                        ? RatingBar(
                                                            initialRating: double.parse(
                                                                item['order_details'][0]['product']
                                                                            [
                                                                            'user_review']
                                                                        [
                                                                        'rating']
                                                                    .toString()),
                                                            minRating: 0.5,
                                                            itemSize: 20,
                                                            direction:
                                                                Axis.horizontal,
                                                            ignoreGestures:
                                                                true,
                                                            allowHalfRating:
                                                                false,
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .blue[900],
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              print(rating);
                                                            },
                                                          )
                                                        : RatingBar(
                                                            initialRating:
                                                                0,
                                                            minRating: 0.5,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                false,
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .blue[900],
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) => Review(
                                                                          item,
                                                                          rating)))
                                                                  .then(
                                                                      (onVal) {
                                                                        setState(() {
                                                                          orderListData = new List();
                                                                        });
                                                                getMyOrders();
                                                              });
                                                            },
                                                          ),
                                                  ],
                                                ))
                                            : SizedBox(),
                                        item['order_details'][0]
                                                    ['delivery_status'] ==
                                                "delivered"
                                            ? SizedBox(
                                                height: 10,
                                              )
                                            : SizedBox()
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList()),
                  )
                : SizedBox()),
        _isLoading
            ? new Stack(
                children: [
                  new Opacity(
                    opacity: 0.3,
                    child: const ModalBarrier(
                        dismissible: false, color: Colors.grey),
                  ),
                  new Center(
                    child: SpinKitRotatingPlain(
                      itemBuilder: _customicon,
                    ),
                  ),
                ],
              )
            : SizedBox()
      ],
    );
  }

  Widget _customicon(BuildContext context, int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/imgs/littardo_logo.png",
          height: 500,
          width: 500,
        ),
      ),
      decoration: new BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: new BorderRadius.circular(5.0)),
    );
  }

  void getMyOrders() {
    setState(() {
      _isLoading = true;
    });
    print(accessToken);
    commeonMethod2(api_url + "orders", accessToken).then((onResponse) async {
      setState(() {
        _isLoading = false;
      });
      Map data = json.decode(onResponse.body);
      print(data);
      if (data['code'] == 200) {
        setState(() {
          orderListData = data['orders'];
        });
      } else {
        presentToast(data['message'], context, 0);
      }
    });
  }
}
