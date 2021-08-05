import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/cart.dart';
import 'package:teeshop/screens/buy_now_screen.dart';
import 'package:teeshop/screens/customize_screen.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = '/info-screen';

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool showDesc = false;
  bool showChart = false;
  var _isLoading = false;
  var width;
  var height;
  var imageSelectedRightNow;
  var _productData;

  void _showDialog(data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(data['data']['name']),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  if (data['data']['descLong'] != null)
                    Text(data['data']['descLong'])
                ],
              ),
            ),
          );
        });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    imageSelectedRightNow = _productData['data']['related_products'].length > 0
        ? _productData['data']['related_products'][0]
        : _productData['data']['url'];
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var related_products = List.from(_productData['data']['related_products']);
    return SafeArea(
      child: Scaffold(
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
                      elevation: 8,
                      child: Column(
                        children: [
                          InteractiveViewer(
                            child: Image.network(
                              imageSelectedRightNow
                                  .toString()
                                  .replaceAll(' ', ''),
                              width: double.infinity,
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                            child: Text(
                              _productData['data']['name'],
                              style: TextStyle(
                                fontSize: width / 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 50,
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
                                      width: width / 25,
                                    ),
                                    Text(
                                      '₹${_productData['data']['price']}/-',
                                      style: TextStyle(
                                          fontSize: width / 20,
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
                  ],
                ),
                SizedBox(
                  height: height / 50,
                ),
                if (_productData['data']['related_products'].length > 0)
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(width / 40),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            related_products.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    imageSelectedRightNow =
                                        related_products[index].toString();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: CircleAvatar(
                                    radius: width / 15,
                                    backgroundImage: NetworkImage(
                                        related_products[index].toString()),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: height / 50,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showDesc = !showDesc;
                    });
                  },
                  child: Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(width / 40),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: width / 25,
                                ),
                              ),
                              Icon(showDesc
                                  ? Icons.expand_less
                                  : Icons.expand_more),
                            ],
                          ),
                          showDesc ? Divider() : Container(),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: showDesc ? height / 4 : 0,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    _productData['data']['descShort'],
                                    style: TextStyle(fontSize: width / 28),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      return _showDialog(_productData);
                                    },
                                    child: Text(
                                      'More Details',
                                      style: TextStyle(fontSize: width / 28),
                                    ),
                                  ),
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
                  height: height / 50,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showChart = !showChart;
                    });
                  },
                  child: Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(width / 40),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Size Chart',
                                style: TextStyle(
                                  fontSize: width / 25,
                                ),
                              ),
                              Icon(showChart
                                  ? Icons.expand_less
                                  : Icons.expand_more),
                            ],
                          ),
                          showChart ? Divider() : Container(),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: showChart ? height / 4 : 0,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  InteractiveViewer(
                                    child: Image.asset(
                                        'assets/images/sizechart.jpeg'),
                                  ),
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
                  height: height / 50,
                ),
                if (_productData['data']['customizable'] != true)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(BuyNowScreen.routeName,
                            arguments: {
                              "product": _productData,
                              "selectedImage": imageSelectedRightNow
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color(0xFF5f0a87),
                          Color(0xFFa4508b)
                        ])),
                        child: Center(
                          child: Text(
                            'Buy Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width / 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: height / 50,
                ),
                if (_productData['data']['customizable'])
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CustomizeScreen.routeName, arguments: {
                          "product": _productData,
                          "selectedImage": imageSelectedRightNow.toString()
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color(0xFF5f0a87),
                          Color(0xFFa4508b)
                        ])),
                        child: Center(
                          child: Text(
                            'Customise',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width / 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: height / 50,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await Provider.of<Cart>(context, listen: false).addCart(
                          context, _productData['data']['id'], height, width);
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF5f0a87), Color(0xFFa4508b)])),
                      child: Center(
                        child: _isLoading
                            ? SizedBox(
                                child: CircularProgressIndicator(),
                                height: width / 10,
                                width: width / 10,
                              )
                            : Text('Add To Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 25,
                                )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
