import 'package:flutter/material.dart';
import 'package:teeshop/data/tee.dart';
import 'package:teeshop/widgets/product_grid.dart';

class BasicTeeScreen extends StatefulWidget {
  @override
  _BasicTeeScreenState createState() => _BasicTeeScreenState();
}

class _BasicTeeScreenState extends State<BasicTeeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProductGrid(),
      ),
    );
  }
}
