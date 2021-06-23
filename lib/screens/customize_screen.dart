import 'package:flutter/material.dart';

class CustomizeScreen extends StatefulWidget {
  static const routeName = '\customize';
  @override
  _CustomizeScreenState createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize ${_productData['data']['name']}'),
      ),
    );
  }
}
