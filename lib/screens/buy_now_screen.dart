import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teeshop/providers/orders.dart';

class BuyNowScreen extends StatefulWidget {
  static const routeName = '/buy-now';

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  dynamic quantity = 1;
  int total = 399;
  TextEditingController qtyController = TextEditingController();
  var productData;
  late Razorpay _razorpay;
  String address = "Enter your address";
  List<String> size = ["S", "M", "L", "XL", "XXL"];
  String dropdownValue = "";
  Map<String, dynamic> buyData = {};
  dynamic quantityText = 11;
  TextEditingController addressEdit = TextEditingController();
  TextEditingController pincodeEdit = TextEditingController();
  GlobalKey<FormState> pincodeKey = GlobalKey();
  var _productData;
  var height;
  var width;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showBottomSheetView(BuildContext context, height, width) {
    showBottomSheet(
        elevation: 40,
        context: context,
        builder: (context) => Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit Address',
                      style: TextStyle(fontSize: width / 25),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Form(
                      key: pincodeKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: addressEdit,
                              maxLines: 5,
                              style: TextStyle(fontSize: width / 25),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(fontSize: width / 25),
                              ),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            TextFormField(
                              controller: pincodeEdit,
                              style: TextStyle(fontSize: width / 25),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Pincode',
                                labelStyle: TextStyle(fontSize: width / 25),
                              ),
                              validator: (value) {
                                if (value.toString() == '') {
                                  return 'Please enter your Pincode';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: width / 25),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              pincodeKey.currentState!.validate();
                              if (addressEdit.text != '' &&
                                  pincodeEdit.text != '') {
                                setState(() {
                                  address = addressEdit.text +
                                      "\n" +
                                      pincodeEdit.text;
                                });
                              } else {
                                setState(() {
                                  address = _productData['product']['user']
                                      ['address'];
                                });
                              }
                              if (addressEdit.text != '' &&
                                  pincodeEdit.text != '') {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Done',
                                style: TextStyle(
                                  fontSize: width / 25,
                                )),
                          ),
                        ])
                  ],
                ),
              ),
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paySuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(_productData);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _onPayment(user, product) {
    if (dropdownValue == "") {
      Fluttertoast.showToast(
          msg: "Please choose your preferred size",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          fontSize: width / 25,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    openCheckout(user, product);
  }

  void openCheckout(userData, productData) {
    var options = {
      "key": "rzp_live_upLxYKABKr7bhM",
      "amount": "${total * 100}",
      "name": "TeeShop",
      "description": "Payment for the mechandise",
      "prefill": {
        "email": userData,
        "size": "$dropdownValue",
        "address": "$address",
        "quantity": "$quantity",
      },
    };

    try {
      _razorpay.open(options);
    } catch (error) {}
  }

  void paySuccess(PaymentSuccessResponse r) async {
    try {
      await Provider.of<Order>(context, listen: false).addOrder(
          context, productData['id'], quantity, dropdownValue, height, width);
      Fluttertoast.showToast(
        msg: "Order placed successfully!",
        backgroundColor: Colors.green,
        fontSize: width / 25,
      );
    } catch (error) {
      print(error);
    }
  }

  void handlerErrorFailure() {
    print('Error!!');
  }

  void handlerExternalWallet() {
    print('External Wallet');
  }

  @override
  Widget build(BuildContext context) {
    total = _productData['product']['data']['price'] * quantity;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('BUY'),
        ),
        body: Builder(
          builder: (context) => Container(
            padding: EdgeInsets.all(width / 80),
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
                                _productData['selectedImage'].toString(),
                                width: double.infinity,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            Container(
                              child: Text(
                                _productData['product']['data']['name'],
                                style: TextStyle(
                                  fontSize: width / 20,
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
                                    '₹${_productData['product']['data']['price']}/-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width / 25),
                                  ),
                                  SizedBox(
                                    width: width / 25,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'QTY: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width / 25),
                                      ),
                                      SizedBox(
                                        width: width / 25,
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
                                                child: Text(
                                                  quantity.toString(),
                                                ),
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
                                      ),
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
                  SizedBox(height: height / 50),
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
                                    fontSize: width / 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: width / 25,
                              ),
                              Expanded(
                                child: DropdownButtonFormField(
                                  style: TextStyle(
                                      fontSize: width / 25,
                                      color: Colors.black),
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
                    height: height / 50,
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
                                    fontSize: width / 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: width / 25,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    child: Text(
                                      "₹" + total.toString() + "/-",
                                      style: TextStyle(fontSize: width / 25),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height / 50),
                  Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address: ',
                                style: TextStyle(
                                    fontSize: width / 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    address.toString(),
                                    style: TextStyle(
                                      fontSize: width / 25,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  'Edit',
                                  style: TextStyle(fontSize: width / 25),
                                ),
                                onPressed: () {
                                  showBottomSheetView(context, height, width);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        return _onPayment(
                            _productData['product']['user']['email'],
                            _productData['product']['data']);
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
                              fontSize: width / 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
      ),
    );
  }
}
