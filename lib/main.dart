import 'package:flutter/material.dart';
import 'package:teeshop/screens/buy_now_custom_screen.dart';
import 'package:teeshop/screens/buy_now_screen.dart';
import 'package:teeshop/screens/customize_screen.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/widgets/app_drawer.dart';
import 'package:teeshop/widgets/product_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeeShop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      home: MyHomePage(),
      routes: {
        InfoScreen.routeName: (context) => InfoScreen(),
        BuyNowScreen.routeName: (context) => BuyNowScreen(),
        CustomizeScreen.routeName: (context) => CustomizeScreen(),
        BuyNowCustom.routeName: (context) => BuyNowCustom(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('TeeShop'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      body: ProductGrid(),
    );
  }
}
