import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  static const routeName = '/contact-us';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    _sendMail() async {
      // Android and iOS
      const uri =
          'mailto:indiateeshop@gmail.com?subject=Query%20To%20TeeshopIndia';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    _call() async {
      // Android and iOS
      const uri = 'tel:01145635397';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    _callWhat() async {
      // Android and iOS
      const uri = "https://wa.me/+919205809145";
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    _callAsh() async {
      // Android and iOS
      const uri = 'tel:+919588955499';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    _callAni() async {
      // Android and iOS
      const uri = 'tel:+918887566721';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
        ),
        body: Container(
          padding: EdgeInsets.all(width / 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.asset('assets/images/3A.png'),
                      Padding(padding: EdgeInsets.all(20)),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'THE CREATORS',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              fontFamily: 'Staatliches'),
                        ),
                      )
                    ],
                  ),
                  elevation: 8,
                ),
                SizedBox(height: height / 30),
                Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(width / 25),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidEnvelope,
                            color: Colors.red,
                            size: width / 15,
                          ),
                          SizedBox(width: width / 20),
                          Text(
                            'indiateeshop@gmail.com',
                            style: TextStyle(fontSize: width / 25),
                          ),
                          TextButton(
                            child: Text(
                              'Mail',
                              style: TextStyle(
                                  fontSize: width / 30, color: Colors.red),
                            ),
                            onPressed: () {
                              _sendMail();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 30),
                Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(width / 25),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FontAwesomeIcons.phoneAlt,
                              color: Colors.green, size: width / 15),
                          SizedBox(width: width / 20),
                          Text(
                            '01145635397',
                            style: TextStyle(fontSize: width / 25),
                          ),
                          SizedBox(width: width / 20),
                          TextButton(
                            child: Text(
                              'Call',
                              style: TextStyle(
                                  fontSize: width / 30, color: Colors.green),
                            ),
                            onPressed: () {
                              _call();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 30),
                Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(width / 25),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FontAwesomeIcons.whatsapp,
                              color: Colors.green, size: width / 15),
                          SizedBox(width: width / 20),
                          Text(
                            '+919205809145',
                            style: TextStyle(fontSize: width / 25),
                          ),
                          SizedBox(width: width / 20),
                          TextButton(
                            child: Text(
                              'Text',
                              style: TextStyle(
                                fontSize: width / 30,
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              _callWhat();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 30),
                Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(width / 25),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FontAwesomeIcons.terminal,
                              color: Colors.blue, size: width / 15),
                          SizedBox(width: width / 20),
                          Text(
                            '+919588955499',
                            style: TextStyle(fontSize: width / 25),
                          ),
                          SizedBox(width: width / 20),
                          TextButton(
                            child: Text(
                              'Call',
                              style: TextStyle(
                                fontSize: width / 30,
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              _callAsh();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 30),
                Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(width / 25),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FontAwesomeIcons.terminal,
                              color: Colors.blue, size: width / 15),
                          SizedBox(width: width / 20),
                          Text(
                            '+918887566721',
                            style: TextStyle(fontSize: width / 25),
                          ),
                          SizedBox(width: width / 20),
                          TextButton(
                            child: Text(
                              'Call',
                              style: TextStyle(
                                fontSize: width / 30,
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              _callAni();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
