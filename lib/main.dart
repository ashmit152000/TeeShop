import 'package:flutter/material.dart';
import 'package:teeshop/screens/about_us.dart';
import 'package:teeshop/screens/buy_now_custom_screen.dart';
import 'package:teeshop/screens/buy_now_screen.dart';
import 'package:teeshop/screens/contact_us.dart';
import 'package:teeshop/screens/customize_screen.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/screens/replacement.dart';
import 'package:teeshop/widgets/app_drawer.dart';

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
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(brightness: Brightness.light),
      ),
      home: MyHomePage(),
      routes: {
        InfoScreen.routeName: (context) => InfoScreen(),
        BuyNowScreen.routeName: (context) => BuyNowScreen(),
        CustomizeScreen.routeName: (context) => CustomizeScreen(),
        BuyNowCustom.routeName: (context) => BuyNowCustom(),
        AboutUs.routeName: (context) => AboutUs(),
        ContactUs.routeName: (context) => ContactUs(),
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
      body: ReplacementScreen(),
    );
  }
}
