import 'package:flutter/material.dart';

class CustomTee extends StatefulWidget {
  const CustomTee({Key? key}) : super(key: key);

  @override
  _CustomTeeState createState() => _CustomTeeState();
}

class _CustomTeeState extends State<CustomTee> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Text('Custom Tees'),
        ),
      ),
    ));
  }
}
