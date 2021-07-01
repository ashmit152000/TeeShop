import 'package:flutter/material.dart';

class CottonShirt extends StatefulWidget {
  const CottonShirt({Key? key}) : super(key: key);

  @override
  _CottonShirtState createState() => _CottonShirtState();
}

class _CottonShirtState extends State<CottonShirt> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Text('Cotton Shirt'),
        ),
      ),
    ));
  }
}
