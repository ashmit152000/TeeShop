import 'package:flutter/material.dart';

class PoloShirt extends StatefulWidget {
  const PoloShirt({Key? key}) : super(key: key);

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
          child: Text('Polo Shirt'),
        ),
      ),
    ));
  }
}
