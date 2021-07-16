import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/favourites.dart';
import 'package:teeshop/providers/products.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/screens/replacement.dart';

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  var _productListOne = [];
  var _userData = {};
  var favList;
  var isFav;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _isLoading = true;
    Provider.of<Product>(context, listen: false)
        .products(context)
        .then((value) {
      setState(() {
        _productListOne = List.from(value["products"]);
        _userData = value["user"];
        _isLoading = false;
      });
    });

    super.didChangeDependencies();
  }

  Future<void> getData() async {
    Provider.of<Product>(context, listen: false)
        .products(context)
        .then((value) {
      setState(() {
        _productListOne = List.from(value["products"]);
        _userData = value["user"];
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
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
                  Navigator.of(context)
                      .pushReplacementNamed(InfoScreen.routeName, arguments: {
                    "data": _productListOne[index],
                    "user": _userData
                  });
                },
                child: GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_productListOne[index]['url']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black87,
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Text(
                          _productListOne[index]['name'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    trailing: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (_productListOne[index]['fav'] == false) {
                                  try {
                                    await Provider.of<Favourites>(context,
                                            listen: false)
                                        .addFavourites(context,
                                            _productListOne[index]['id']);
                                  } catch (error) {
                                    setState(() {
                                      _productListOne[index]['fav'] = false;
                                    });
                                    print(error.toString());
                                  }
                                } else {
                                  try {
                                    await Provider.of<Favourites>(context,
                                            listen: false)
                                        .removeFavourites(context,
                                            _productListOne[index]['id']);
                                  } catch (error) {
                                    setState(() {
                                      _productListOne[index]['fav'] = false;
                                    });
                                    print(error.toString());
                                  }
                                }

                                await getData();
                              },
                              icon: Icon(
                                _productListOne[index]['fav']
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: _productListOne.length,
          );
  }
}
