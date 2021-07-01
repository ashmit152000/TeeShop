import 'package:flutter/material.dart';
import 'package:teeshop/data/polyester.dart';
import 'package:teeshop/widgets/product_grid.dart';

class PolyesterScreen extends StatefulWidget {
  @override
  _PolyesterScreenState createState() => _PolyesterScreenState();
}

class _PolyesterScreenState extends State<PolyesterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProductGrid(Polyester.productList),
      ),
    );
  }
}
