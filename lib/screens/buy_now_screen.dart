import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teeshop/providers/orders.dart';
import 'package:teeshop/screens/your_profile_screen.dart';

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
  var address;
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
  var _isLoading = false;
  bool showChart = false;
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
    address = _productData['product']['user']['address'] != null
        ? _productData['product']['user']['address']
        : 'Edit your address';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
    addressEdit.dispose();
    pincodeEdit.dispose();
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
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Order>(context, listen: false).addOrder(
          context, height, width,
          product_id: _productData['product']['data']['id'],
          qty: quantity,
          size: dropdownValue,
          price: _productData['product']['data']['id'],
          address: address,
          urlOne: _productData['selectedImage'].toString());
      setState(() {
        _isLoading = false;
      });
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
        body: _isLoading
            ? Center(
                child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: width / 10,
                    width: width / 10),
              )
            : Builder(
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
                                        items: size
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        decoration: InputDecoration(
                                            labelText: 'Select Size',
                                            filled: true),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 40,
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
                                          fontWeight: FontWeight.bold,
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
                                            style:
                                                TextStyle(fontSize: width / 25),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        showBottomSheetView(
                                            context, height, width);
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
                              if (address != '' &&
                                  _productData['product']['user']
                                          ['phone_verified'] !=
                                      false) {
                                return _onPayment(
                                    _productData['product']['user']['email'],
                                    _productData['product']['data']);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Profile Issue',
                                          style: TextStyle(
                                              fontSize: width / 20,
                                              color: Colors.purple),
                                        ),
                                        content: Text(
                                          'You haven\'t selected an address for delivery. Or your Phone Number is not verified',
                                          style:
                                              TextStyle(fontSize: width / 25),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  fontSize: width / 25),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  YourProfileScreen.routeName);
                                            },
                                            child: Text(
                                              'Go To Profile',
                                              style: TextStyle(
                                                  fontSize: width / 25),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              }
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
