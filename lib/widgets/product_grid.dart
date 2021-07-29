import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:teeshop/providers/products.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/screens/replacement.dart';

class ProductGrid extends StatefulWidget {
  var _productListOne = [];
  var _userData = {};
  ProductGrid(this._productListOne, this._userData);
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  var _productListOne = [];
  var _userData = {};
  var favList;
  var height;
  var width;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  Future<void> getData() async {
    Provider.of<Product>(context, listen: false)
        .products(context)
        .then((value) {
      setState(() {
        widget._productListOne = List.from(value["products"]);
        widget._userData = value["user"];
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(milliseconds: 500), () {
                setState(() {});
              });
            },
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("Pressed $index");
                    Navigator.of(context).pushNamed(InfoScreen.routeName,
                        arguments: {
                          "data": widget._productListOne[index],
                          "user": widget._userData
                        });
                  },
                  child: GridTile(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: FadeInImage(
                        placeholder:
                            AssetImage('assets/images/product-placeholder.png'),
                        image: NetworkImage(
                          widget._productListOne[index]['url'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black87,
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Text(
                            widget._productListOne[index]['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width / 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget._productListOne.length,
            ),
          );
  }
}
