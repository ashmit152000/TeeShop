import 'package:flutter/material.dart';

class Hoodie extends StatefulWidget {
  const Hoodie({Key? key}) : super(key: key);

  @override
  _HoodieState createState() => _HoodieState();
}

class _HoodieState extends State<Hoodie> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Text('Hoodie'),
        ),
      ),
    ));
  }
}
