import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
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
        return GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.shopify.com/s/files/1/0981/8178/files/Spread-collar-casual-shirt.jpg?525'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Text('Shirt Marvel',
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
        );
      },
      itemCount: 10,
    );
  }
}
