import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 20),
              height: MediaQuery.of(context).size.height * 0.2,
              color: Theme.of(context).primaryColor,
              child: Text(
                'TeeShop',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  size: 30.0,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                size: 30.0,
              ),
              title: Text(
                "Favourites",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                size: 30.0,
              ),
              title: Text(
                "Wishlist",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.money,
                size: 30.0,
              ),
              title: Text(
                "Orders",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30.0,
              ),
              title: Text(
                "My Profile",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 30.0,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
