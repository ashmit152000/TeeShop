import 'package:flutter/material.dart';

class EmbroPolo extends StatefulWidget {
  const EmbroPolo({Key? key}) : super(key: key);

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
