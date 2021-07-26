import 'package:flutter/material.dart';
import 'package:teeshop/widgets/product_grid.dart';

class CustomTee extends StatefulWidget {
  var _productsList = [];
  var userData = {};
  CustomTee(this._productsList, this.userData);
  @override
  _CustomTeeState createState() => _CustomTeeState();
}

class _CustomTeeState extends State<CustomTee> {
  @override
  Widget build(BuildContext context) {
    var productList = List.from(widget._productsList
        .where((element) => element['product_type'] == 'custom'));
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: ProductGrid(productList, widget.userData),
        ),
      ),
    ));
  }
}
