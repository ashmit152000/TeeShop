import 'package:flutter/material.dart';
import 'package:teeshop/widgets/product_grid.dart';

class PoloShirt extends StatefulWidget {
  var _productsList = [];
  var userData = {};

  PoloShirt(this._productsList, this.userData);

  @override
  _PoloShirtState createState() => _PoloShirtState();
}

class _PoloShirtState extends State<PoloShirt> {
  @override
  Widget build(BuildContext context) {
    var productList = List.from(widget._productsList
        .where((element) => element['product_type'] == 'polo'));
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
