import 'package:flutter/material.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class FavouritesScreen extends StatefulWidget {
  static const routeName = '/fav';
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(title: Text('TeeShop')),
        body: Container(
          child: Center(
            child: Text('Favourites'),
          ),
        ),
      ),
    );
  }
}
