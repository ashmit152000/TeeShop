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
  String address =
      "QTR No. S/2, \n S-Block, \n Hudco Extension, \n Near Ansal Plaza, \n 110049, \n Delhi, New Delhi";
  List<String> size = ["S", "M", "L", "XL", "XXL"];
  String dropdownValue = "";
  Map<String, dynamic> buyData = {};
  dynamic quantityText = 11;
  TextEditingController addressEdit = TextEditingController();
  TextEditingController pincodeEdit = TextEditingController();
  GlobalKey<FormState> pincodeKey = GlobalKey();
  var _productData;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showBottomSheetView(BuildContext context) {
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
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: pincodeKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: addressEdit,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(labelText: 'Address'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: pincodeEdit,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: 'Pincode'),
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
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
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
                                  address = _productData['user']['address'];
                                });
                              }
                              if (addressEdit.text != '' &&
                                  pincodeEdit.text != '') {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Done'),
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
    // Fluttertoast.showToast(msg: quantity.toString());
    // Fluttertoast.showToast(msg: dropdownValue.toString());
    try {
      await Provider.of<Order>(context, listen: false)
          .addOrder(context, productData['id'], quantity, dropdownValue);
      Fluttertoast.showToast(
          msg: "Order placed successfully!", backgroundColor: Colors.green);
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    total = _productData['data']['price'] * quantity;

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
                                _productData['data']['url'],
                                width: double.infinity,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            Container(
                              child: Text(
                                _productData['data']['name'],
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
                                    '₹${_productData['data']['price']}/-',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                        width: width / 40,
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    child: Text(
                                      "₹" + total.toString() + "/-",
                                      style: TextStyle(fontSize: 15),
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
                  SizedBox(height: 10),
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
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    address.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                child: Text('Edit'),
                                onPressed: () {
                                  showBottomSheetView(context);
                                },
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
                        return _onPayment(_productData['user']['email'],
                            _productData['data']);
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
          ),
        ),
      ),
    );
  }
}
