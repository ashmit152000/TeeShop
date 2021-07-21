import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Sandose'),
        ),
      ),
    );
  }
}
