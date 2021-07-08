import 'package:flutter/material.dart';
import 'package:teeshop/screens/info_screen.dart';

class ProductGrid extends StatelessWidget {
  List<Map<String, dynamic>> _productList;
  ProductGrid(this._productList);
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
                arguments: {"data": _productList[index]});
          },
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_productList[index]['url']),
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
                    _productList[index]['name'],
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
                      GestureDetector(
                        child: Icon(Icons.favorite_outline, color: Colors.red),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: _productList.length,
    );
  }
}
