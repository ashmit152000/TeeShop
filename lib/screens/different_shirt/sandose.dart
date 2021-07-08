import 'package:flutter/material.dart';

class Sandose extends StatefulWidget {
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
