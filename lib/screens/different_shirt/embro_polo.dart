import 'package:flutter/material.dart';

class EmbroPolo extends StatefulWidget {
  var _productsList = [];
  var userData = {};

  EmbroPolo(this._productsList, this.userData);

  @override
  _EmbroPoloState createState() => _EmbroPoloState();
}

class _EmbroPoloState extends State<EmbroPolo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Text('Embroidery'),
        ),
      ),
    ));
  }
}
