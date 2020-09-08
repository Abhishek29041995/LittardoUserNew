import 'package:flutter/material.dart';
import 'package:littardo/widgets/split_screen.dart';
import 'package:littardo/models/product.dart';

class CompareProducts extends StatefulWidget {
  final Product product;

  const CompareProducts({Key key, this.product}) : super(key: key);

  _CompareProducts createState() => _CompareProducts();
}

class _CompareProducts extends State<CompareProducts> {
  @override
  Widget build(BuildContext context) {
    Scaffold(
      appBar: AppBar(
        title: Text("Compare"),
      ),
      body: SplitView(
        initialWeight: 0.7,
        view1: SplitView(
          viewMode: SplitViewMode.Horizontal,
          view1: Container(
            child: Center(child: Text("View1")),
            color: Colors.red,
          ),
          view2: Container(
            child: Center(child: Text("View2")),
            color: Colors.blue,
          ),
          onWeightChanged: (w) => print("Horizon: $w"),
        ),
        view2: Container(
          child: Center(
            child: Text("View3"),
          ),
          color: Colors.green,
        ),
        viewMode: SplitViewMode.Vertical,
        onWeightChanged: (w) => print("Vertical $w"),
      ),
    );
  }
}
