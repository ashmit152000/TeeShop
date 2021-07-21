import 'package:flutter/material.dart';

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
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Text('Full Sleeves'),
        ),
      ),
    ));
  }
}
