import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:teeshop/screens/different_shirt/cotton.dart';
import 'package:teeshop/screens/different_shirt/full_sleeves.dart';
import 'package:teeshop/screens/different_shirt/hoodie.dart';
import 'package:teeshop/screens/different_shirt/polo.dart';
import 'package:teeshop/screens/different_shirt/polyester.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class ReplacementScreen extends StatefulWidget {
  const ReplacementScreen({Key? key}) : super(key: key);

  @override
  _ReplacementScreenState createState() => _ReplacementScreenState();
}

class _ReplacementScreenState extends State<ReplacementScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple,
      statusBarBrightness: Brightness.light,
    ));
    return SafeArea(
      child: DefaultTabController(
        length: 5,
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
                  child: Text('Polyester Shirts'),
                ),
                Tab(
                  child: Text('Cotton Shirts'),
                ),
                Tab(
                  child: Text('Full Sleeves'),
                ),
                Tab(
                  child: Text('Polo Shirt'),
                ),
                Tab(
                  child: Text('Hoodies'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PolyesterScreen(),
              CottonShirt(),
              FullSleeves(),
              PoloShirt(),
              Hoodie(),
            ],
          ),
        ),
      ),
    );
  }
}
