import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            title: Text('TeeShop'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.shopping_cart, color: Colors.white),
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
              BasicTeeScreen(),
              CustomTee(),
              Sandose(),
              FullSleeves(),
              PoloShirt(),
              EmbroPolo(),
            ],
          ),
        ),
      ),
    );
  }
}
