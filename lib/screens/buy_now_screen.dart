import 'package:flutter/material.dart';

class BuyNowScreen extends StatefulWidget {
  static const routeName = '\buy-now';

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  int quantity = 1;
  String address =
      "QTR No. S/2, \n S-Block, \n Hudco Extension, \n Near Ansal Plaza, \n 110049, \n Delhi, New Delhi";
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int total = _productData['data']['price'] * quantity;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('BUY ${_productData['data']['name']}'),
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Card(
                          elevation: 8,
                          child: Column(
                            children: [
                              InteractiveViewer(
                                child: Image.network(
                                  _productData['data']['url'],
                                  width: double.infinity,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              Container(
                                child: Text(
                                  _productData['data']['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '₹${_productData['data']['price']}/-',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'QTY: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          color: Colors.purple,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (quantity > 1) {
                                                        quantity--;
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(Icons.remove,
                                                      color: Colors.white)),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                color: Colors.white,
                                                child: Center(
                                                  child:
                                                      Text(quantity.toString()),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      quantity++;
                                                    });
                                                  },
                                                  icon: Icon(Icons.add,
                                                      color: Colors.white)),
                                            ],
                                          ),
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
                    Card(
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Amount: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "₹" + total.toString() + "/-",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 8,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Address: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  address,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {},
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )));
  }
}
