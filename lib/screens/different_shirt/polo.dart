import 'package:flutter/material.dart';

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
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Text('Custom Polo'),
        ),
      ),
    ));
  }
}
