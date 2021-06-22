import 'package:flutter/material.dart';
import 'package:teeshop/screens/info_screen.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> _productList = [
    {
      "id": "1",
      "name": "Shirt 1",
      "url":
          "https://cdn.shopify.com/s/files/1/0981/8178/files/Spread-collar-casual-shirt.jpg?525",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "2",
      "name": "Shirt 2",
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRx66hp_1Tozx816L8zhtD5lJHHv8NJG4xNQ&usqp=CAU",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "3",
      "name": "Shirt 3",
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1tCGBUclaCpaoC9lXs3P6tbsr9wQJB7kcQQ&usqp=CAU",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "4",
      "name": "Shirt 4",
      "url":
          "https://assetscdn1.paytm.com/images/catalog/product/A/AP/APPEYEBOGLER-COSEVE88413F32E363/1601890054864_0..jpg",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "5",
      "name": "Shirt 5",
      "url":
          "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/tshirts-1613587154.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "6",
      "name": "Shirt 6",
      "url":
          "https://www.collinsdictionary.com/images/full/tshirt_204029461_1000.jpg",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "7",
      "name": "Shirt 7",
      "url":
          "https://rukminim1.flixcart.com/image/714/857/k65d18w0/shirt/p/4/t/48-bfrybluesht02ab-being-fab-original-imaecvnxndp3zbdn.jpeg?q=50",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "8",
      "name": "Shirt 8",
      "url":
          "https://images.bestsellerclothing.in/data/JJ/04-08-2019/12152356-Black_8.jpg?width=1080&height=1355&mode=fill&fill=blur&format=auto",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "9",
      "name": "Shirt 9",
      "url":
          "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/button-down-1566926976.jpg?crop=0.423xw:0.846xh;0.0321xw,0.0577xh&resize=640:*",
      "available_sizes": ["S", "M", "L", "XL", "XXL"],
      "price": 399,
      "descShort": "This is a product",
      "descLong":
          "This is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a productThis is a product",
    },
    {
      "id": "10",
      "name": "Shirt 10",
      "url": "https://www.marni.com/12/12386489mt_13_n_r.jpg",
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
                    image: NetworkImage(_productList[index]['url']),
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
