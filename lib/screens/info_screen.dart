import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = '/info-screen';

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool showDesc = false;

  void _showDialog(data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(data['data']['name']),
            content: SingleChildScrollView(
              child: Column(
                children: [Text(data['data']['descLong'])],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(_productData);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('TeeShop'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Image.network(
                          _productData['data']['url'],
                          width: double.infinity,
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          child: Text(
                            _productData['data']['name'],
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.tags,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    '₹${_productData['data']['price']}/-',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   width: double.infinity,
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     '₹399/-',
                  //     style: TextStyle(color: Colors.white, fontSize: 20),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       colors: [Color(0xFFf53844), Color(0xFF864ba2)],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDesc = !showDesc;
                  });
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Description'),
                            Icon(showDesc
                                ? Icons.expand_less
                                : Icons.expand_more),
                          ],
                        ),
                        showDesc ? Divider() : Container(),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: showDesc ? 100 : 0,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  _productData['data']['descShort'],
                                ),
                                TextButton(
                                    onPressed: () {
                                      return _showDialog(_productData);
                                    },
                                    child: Text('More Details'))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF5f0a87), Color(0xFFa4508b)])),
                  child: Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF5f0a87), Color(0xFFa4508b)])),
                  child: Center(
                    child: Text('Customize',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF5f0a87), Color(0xFFa4508b)])),
                    child: Center(
                      child: Text('Add To Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
