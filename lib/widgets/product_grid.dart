import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/data/tee.dart';
import 'package:teeshop/providers/favourites.dart';
import 'package:teeshop/screens/info_screen.dart';

class ProductGrid extends StatefulWidget {
  List<Map<String, dynamic>> _productList;

  ProductGrid(this._productList);

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  var _productListOne = [];

  @override
  void initState() {
    super.initState();
    _productListOne = List.from(widget._productList);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
            Navigator.of(context).pushReplacementNamed(InfoScreen.routeName,
                arguments: {"data": _productListOne[index]});
          },
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_productListOne[index]['url']),
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
                          print('Clicked');
                          var isFav = _productListOne[index]['fav'];
                          setState(() {
                            _productListOne[index].update(
                                'fav', (existingValue) => !existingValue);
                          });

                          try {
                            await Provider.of<Favourites>(context,
                                    listen: false)
                                .addFavourites(
                                    merch_cost: widget._productList[index]
                                        ['price'],
                                    merch_name: widget._productList[index]
                                        ['name'],
                                    merch_id: int.parse(
                                        widget._productList[index]['id']),
                                    merch_url: widget._productList[index]
                                        ['url']);
                          } catch (error) {
                            setState(() {
                              _productListOne[index]['fav'] = isFav;
                            });
                            print(error.toString());
                          }
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
