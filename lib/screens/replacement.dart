import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/products.dart';

import 'package:teeshop/screens/different_shirt/custom_tee.dart';
import 'package:teeshop/screens/different_shirt/full_sleeves.dart';
import 'package:teeshop/screens/different_shirt/embro_polo.dart';
import 'package:teeshop/screens/different_shirt/polo.dart';
import 'package:teeshop/screens/different_shirt/polyester.dart';
import 'package:teeshop/screens/different_shirt/sandose.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class ReplacementScreen extends StatefulWidget {
  static const routeName = '/replacement';
  @override
  _ReplacementScreenState createState() => _ReplacementScreenState();
}

class _ReplacementScreenState extends State<ReplacementScreen> {
  var _productListOne = [];
  var _userData = {};
  var favList;
  var isFav;
  var _isLoading = false;
  var _cartCount = 0;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      _isLoading = true;
    });

    Provider.of<Product>(context, listen: false)
        .products(context)
        .then((value) {
      setState(() {
        _productListOne = List.from(value["products"]);
        _userData = value["user"];
        _cartCount = value["cartCount"];
        _isLoading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading != true
          ? DefaultTabController(
              length: 6,
              child: Scaffold(
                drawer: AppDrawer(),
                appBar: AppBar(
                  title: Text('TeeShop'),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Badge(
                          badgeContent:
                              Text(_cartCount > 0 ? "$_cartCount" : "0"),
                          child:
                              Icon(Icons.shopping_cart, color: Colors.white)),
                    ),
                  ],
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Text('Basic White Tees'),
                      ),
                      Tab(
                        child: Text('Custom Tees'),
                      ),
                      Tab(
                        child: Text('Sandose'),
                      ),
                      Tab(
                        child: Text('Full Sleeves'),
                      ),
                      Tab(
                        child: Text('Custom Polos'),
                      ),
                      Tab(
                        child: Text('Embroidered Polos'),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    BasicTeeScreen(_productListOne, _userData),
                    CustomTee(),
                    Sandose(),
                    FullSleeves(),
                    PoloShirt(),
                    EmbroPolo(),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
