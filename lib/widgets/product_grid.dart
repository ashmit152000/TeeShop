import 'package:flutter/material.dart';
import 'package:teeshop/screens/info_screen.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> _productList = [
    {
      "id": "1",
      "name": "Shirt 1",
      "url": "assets/images/black.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "2",
      "name": "Shirt 2",
      "url": "assets/images/blue.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "3",
      "name": "Shirt 3",
      "url": "assets/images/green.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "4",
      "name": "Shirt 4",
      "url": "assets/images/pink.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "5",
      "name": "Shirt 5",
      "url": "assets/images/purple.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "6",
      "name": "Shirt 6",
      "url": "assets/images/red.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "7",
      "name": "Shirt 7",
      "url": "assets/images/white.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "8",
      "name": "Shirt 8",
      "url": "assets/images/yellow.png",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
  ];

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
              leading: Text(_productList[index]['name'],
                  style: TextStyle(
                    color: Colors.white,
                  )),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.favorite_outline, color: Colors.red),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        child: Icon(Icons.edit, color: Colors.red),
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
