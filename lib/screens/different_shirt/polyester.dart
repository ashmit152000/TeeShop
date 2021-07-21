import 'package:flutter/material.dart';
import 'package:teeshop/data/tee.dart';
import 'package:teeshop/widgets/product_grid.dart';

class BasicTeeScreen extends StatefulWidget {
  var _productsList = [];
  var userData = {};
  BasicTeeScreen(this._productsList, this.userData);
  @override
  _BasicTeeScreenState createState() => _BasicTeeScreenState();
}

class _BasicTeeScreenState extends State<BasicTeeScreen> {
  @override
  Widget build(BuildContext context) {
    var productList = List.from(widget._productsList
        .where((element) => element['product_type'] == 'basic'));
    return SafeArea(
      child: Scaffold(
        body: ProductGrid(productList, widget.userData),
      ),
    );
  }
}
