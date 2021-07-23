import 'package:flutter/material.dart';
import 'package:teeshop/widgets/product_grid.dart';

class FullSleeves extends StatefulWidget {
  var _productsList = [];
  var userData = {};

  FullSleeves(this._productsList, this.userData);

  @override
  _FullSleevesState createState() => _FullSleevesState();
}

class _FullSleevesState extends State<FullSleeves> {
  @override
  Widget build(BuildContext context) {
    var productList = List.from(widget._productsList
        .where((element) => element['product_type'] == 'full'));
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
