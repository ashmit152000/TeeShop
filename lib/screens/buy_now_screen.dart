import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BuyNowScreen extends StatefulWidget {
  static const routeName = '/buy-now';

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  int quantity = 1;
  int total = 399;
  late Razorpay _razorpay;
  String address =
      "QTR No. S/2, \n S-Block, \n Hudco Extension, \n Near Ansal Plaza, \n 110049, \n Delhi, New Delhi";
  List<String> size = ["S", "M", "L", "XL", "XXL"];
  String dropdownValue = "";
  Map<String, dynamic> buyData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _onPayment() {
    if (dropdownValue == "") {
      Fluttertoast.showToast(
          msg: "Please choose your preferred size",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    openCheckout();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_hgB0mMGhnOqSzT",
      "amount": "${total * 100}",
      "size": "$dropdownValue",
      "address": "$address",
      "quantity": "$quantity",
      "name": "TeeShop",
      "description": "Payment for the mechandise",
      "prefill": {
        "contact": "9588955499",
        "email": "ashmitteeshop@gmail.com",
      },
      "external": {
        "wallets": ["paytm", "paypal"]
      }
    };

    try {
      _razorpay.open(options);
    } catch (error) {}
  }

  void handlerPaymentSuccess() {
    print('Success!!');
  }

  void handlerErrorFailure() {
    print('Error!!');
  }

  void handlerExternalWallet() {
    print('External Wallet');
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Map<String, dynamic> buyData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    total = _productData['data']['price'] * quantity;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('BUY'),
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
                                child: Image.asset(
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
                                  'Size: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValue = newValue.toString();
                                      });
                                    },
                                    validator: (newValue) {
                                      if (dropdownValue == "") {
                                        return "Please choose your preferred size";
                                      }
                                    },
                                    items: size.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    decoration: InputDecoration(
                                        labelText: 'Select Size', filled: true),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        onTap: () {
                          return _onPayment();
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
                              'CHECK OUT',
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
