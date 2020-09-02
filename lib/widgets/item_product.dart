import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:littardo/models/product.dart';
import 'package:littardo/screens/product.dart';
import 'package:littardo/widgets/star_rating.dart';

class TrendingItem extends StatelessWidget {
  final Product product;
  final List<Color> gradientColors;

  TrendingItem({this.product, this.gradientColors});

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = 140;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: trendCardWidth,
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(
                          Ionicons.getIconData(product.isWishlisted == "1"
                              ? "ios-heart"
                              : "ios-heart-empty"),
                          color: Colors.black54,
                        )
                      ],
                    ),
                    _productImage(),
                    _productDetails()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductPage(
              product: product,
            ),
          ),
        );
      },
    );
  }

  _productImage() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(product.icon,),fit: BoxFit.contain,
            ),
          ),
        )
      ],
    );
  }

  _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   product.company,
        //   style: TextStyle(fontSize: 12, color: Color(0XFFb1bdef)),
        // ),
        Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        product.rating != null
            ? StarRating(rating: product.rating, size: 10)
            : SizedBox(),
        product.price != null
            ? Row(
                children: <Widget>[
                  Text(product.price,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                  Text(
                    product.originalPrice,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough),
                  )
                ],
              )
            : SizedBox()
      ],
    );
  }
}
