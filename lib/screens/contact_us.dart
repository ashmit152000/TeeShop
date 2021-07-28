import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  static const routeName = '/contact-us';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.asset('assets/images/3A.png'),
                      Padding(padding: EdgeInsets.all(20)),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'THE THREE MUSKETEERS ',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              fontFamily: 'Jomhuria'),
                        ),
                      )
                    ],
                  ),
                  elevation: 8,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Contact us directly at: \n ashmitteeshop@gmail.com\n teeshopindia@gmail.com\n anirudhteeshop@gmail.com',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 40),
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
