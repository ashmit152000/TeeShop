import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/auth.dart';
import 'package:teeshop/screens/about_us.dart';
import 'package:teeshop/screens/contact_us.dart';
import 'package:teeshop/screens/order_cart_screen.dart';
import 'package:teeshop/screens/order_screen.dart';

class AppDrawer extends StatefulWidget {
  var userData;
  AppDrawer({this.userData});
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
                Navigator.of(context).pop();
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(OrderCartScreen.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  size: 30.0,
                ),
                title: Text(
                  "Wishlist",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Divider(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(OrderScreen.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.money,
                  size: 30.0,
                ),
                title: Text(
                  "Orders",
                  style: TextStyle(fontSize: 15),
                ),
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
              title: GestureDetector(
                onTap: () {
                  if (widget.userData['confirmed'] != true) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Verify email',
                          style: TextStyle(color: Colors.purple),
                        ),
                        content: Text(
                            'Your email is not verified. Please verify it'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await Provider.of<Auth>(context, listen: false)
                                  .sendVerification();
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: 'Verification link sent to your email');
                              setState(() {});
                            },
                            child: Text('SEND VERIFICATION'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Text(
                      "My Profile",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 10,
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
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AboutUs.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  size: 30.0,
                ),
                title: Text(
                  "About Us",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Divider(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(ContactUs.routeName);
              },
              child: ListTile(
                leading: Icon(
                  Icons.contact_mail,
                  size: 30.0,
                ),
                title: Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 15),
                ),
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
