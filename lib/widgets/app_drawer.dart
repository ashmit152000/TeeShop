import 'package:flutter/material.dart';
import 'package:teeshop/screens/about_us.dart';
import 'package:teeshop/screens/contact_us.dart';
import 'package:teeshop/screens/order_cart_screen.dart';
import 'package:teeshop/screens/order_screen.dart';
import 'package:teeshop/screens/your_profile_screen.dart';

class AppDrawer extends StatefulWidget {
  var userData;

  AppDrawer({this.userData});
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var height;
  var width;
  @override
  void didChangeDependencies() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 20),
              height: MediaQuery.of(context).size.height * 0.2,
              color: Theme.of(context).primaryColor,
              child: Text(
                'TeeshopIndia',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width / 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  size: width / 15,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: width / 25,
                  ),
                ),
              ),
            ),
            Divider(
              height: height / 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(OrderCartScreen.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  size: width / 15,
                ),
                title: Text(
                  "Wishlist",
                  style: TextStyle(
                    fontSize: width / 25,
                  ),
                ),
              ),
            ),
            Divider(
              height: height / 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(OrderScreen.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.money,
                  size: width / 15,
                ),
                title: Text(
                  "Orders",
                  style: TextStyle(
                    fontSize: width / 25,
                  ),
                ),
              ),
            ),
            Divider(
              height: height / 50,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: width / 15,
              ),
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(YourProfileScreen.routeName,
                      arguments: widget.userData);
                },
                child: Row(
                  children: [
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: width / 25,
                      ),
                    ),
                    SizedBox(
                      width: height / 55,
                    ),
                    if (widget.userData['confirmed'] != true)
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      )
                  ],
                ),
              ),
            ),
            Divider(
              height: height / 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AboutUs.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  size: width / 15,
                ),
                title: Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: width / 25,
                  ),
                ),
              ),
            ),
            Divider(
              height: height / 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(ContactUs.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.contact_mail,
                  size: width / 15,
                ),
                title: Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: width / 25,
                  ),
                ),
              ),
            ),
            Divider(
              height: height / 50,
            ),
          ],
        ),
      ),
    );
  }
}
