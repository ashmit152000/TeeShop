import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/auth.dart';
import 'package:teeshop/providers/products.dart';

import 'package:teeshop/screens/different_shirt/custom_tee.dart';
import 'package:teeshop/screens/different_shirt/full_sleeves.dart';

import 'package:teeshop/screens/different_shirt/polo.dart';
import 'package:teeshop/screens/different_shirt/polyester.dart';
import 'package:teeshop/screens/different_shirt/sandose.dart';
import 'package:teeshop/screens/order_cart_screen.dart';
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
  var height;
  var width;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Do you want to exit ?',
              style: TextStyle(color: Colors.purple),
            ),
            content: new Text('We were enjoying your time with us.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this._onWillPop,
      child: SafeArea(
        child: _isLoading != true
            ? DefaultTabController(
                length: 5,
                child: Scaffold(
                  drawer: AppDrawer(userData: _userData),
                  drawerEnableOpenDragGesture: false,
                  appBar: AppBar(
                    title: Text(
                      'TeeshopIndia',
                      style: TextStyle(fontSize: width / 25),
                    ),
                    actions: [
                      Padding(
                        padding:
                            EdgeInsets.only(right: width / 15, top: width / 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(OrderCartScreen.routeName);
                          },
                          child: Badge(
                            badgeContent:
                                Text(_cartCount > 0 ? "$_cartCount" : "0"),
                            child:
                                Icon(Icons.shopping_cart, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: width / 30, top: width / 30),
                        child: IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text(
                                      'Do you want to logout ?',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                    content: Text(
                                        'We were enjoying your time with us. Join us soon'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          Navigator.of(context).pop();
                                          await Provider.of<Auth>(context,
                                                  listen: false)
                                              .logout();

                                          setState(() {
                                            _isLoading = false;
                                          });
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      )
                    ],
                    bottom: TabBar(
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            'Custom Merchs',
                            style: TextStyle(fontSize: width / 28),
                          ),
                        ),

                        Tab(
                          child: Text(
                            'Tees',
                            style: TextStyle(fontSize: width / 28),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Full Sleeves',
                            style: TextStyle(fontSize: width / 28),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Polo Tees',
                            style: TextStyle(fontSize: width / 28),
                          ),
                        ),
                        // Tab(
                        //   child: Text('Embroidered Polos'),
                        // ),
                        Tab(
                          child: Text(
                            'Sandos',
                            style: TextStyle(fontSize: width / 28),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      CustomTee(_productListOne, _userData),

                      BasicTeeScreen(_productListOne, _userData),
                      FullSleeves(_productListOne, _userData),
                      PoloShirt(_productListOne, _userData),
                      Sandose(_productListOne, _userData),
                      // EmbroPolo(_productListOne, _userData),
                    ],
                  ),
                ),
              )
            : Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: width / 10,
                  width: width / 10,
                ),
              ),
      ),
    );
  }
}
