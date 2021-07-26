import 'package:flutter/material.dart';
import 'package:teeshop/widgets/product_grid.dart';

class Sandose extends StatefulWidget {
  var _productsList = [];
  var userData = {};
  Sandose(this._productsList, this.userData);
  @override
  _SandoseState createState() => _SandoseState();
}

class _SandoseState extends State<Sandose> {
  @override
  Widget build(BuildContext context) {
    var productList = List.from(widget._productsList
        .where((element) => element['product_type'] == 'san'));
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ProductGrid(productList, widget.userData),
        ),
      ),
    );
  }
}
