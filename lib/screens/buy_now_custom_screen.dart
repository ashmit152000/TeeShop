import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teeshop/providers/orders.dart';

class BuyNowCustom extends StatefulWidget {
  @override
  _BuyNowCustomState createState() => _BuyNowCustomState();
  static const routeName = "/buy_now_custom";
}

class _BuyNowCustomState extends State<BuyNowCustom> {
  int quantity = 1;
  var address;
  var total;
  var width;
  var height;
  String dropdownValue = "";
  List<String> size = ["S", "M", "L", "XL", "XXL"];
  var args;
  late Razorpay _razorpay;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    address = args['address'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  TextEditingController addressEdit = TextEditingController();
  TextEditingController pincodeEdit = TextEditingController();
  GlobalKey<FormState> pincodeKey = GlobalKey();
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
                      style: TextStyle(
                        fontSize: width / 15,
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: width / 30,
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
                            child: Text('Cancel',
                                style: TextStyle(fontSize: width / 25)),
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
                                  address = args['address'];
                                });
                              }
                              if (addressEdit.text != '' &&
                                  pincodeEdit.text != '') {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(fontSize: width / 25),
                            ),
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

  void _onPayment(user, product) {
    if (dropdownValue == "") {
      Fluttertoast.showToast(
          msg: "Please choose your preferred size",
          fontSize: width / 25,
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
        "email": args['product']['user']['email'],
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
      await Provider.of<Order>(context, listen: false).addOrder(
          context,
          args['product']['data']['id'],
          quantity,
          dropdownValue,
          height,
          width);
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
    total = args['price'] * quantity;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("BUY"),
        ),
        body: Builder(
          builder: (context) => Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          args["related_products"],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (args["selectedImage"] != null &&
                            args["_isIconPresent"] != false)
                          Positioned(
                            top: args['iconY'],
                            left: args['iconX'],
                            child: Transform.rotate(
                              angle: args["angle"],
                              child: SvgPicture.asset(
                                args['selectedImage'],
                                height: args["iconSize"].toDouble(),
                                colorBlendMode: BlendMode.srcATop,
                                allowDrawingOutsideViewBox: false,
                                color: args['selectedColor'],
                              ),
                            ),
                          ),
                        if (args["text"] != null &&
                            args["_isTextPresent"] != false)
                          Positioned(
                            top: args['textY'],
                            left: args['textX'],
                            child: Transform.rotate(
                              angle: args["textRotation"],
                              child: Text(
                                args["text"],
                                style: TextStyle(
                                    fontSize: args["textSize"],
                                    fontFamily: args["fontFamily"],
                                    color: args["textColor"]),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!args['product']['data']['customizable'])
                    SizedBox(
                      height: 10,
                    ),
                  Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quantity: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width / 25),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
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
                                            child: Text(quantity.toString()),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height / 40),
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
                    height: height / 40,
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
                                width: 10,
                              ),
                              Text(
                                "₹" + total.toString() + "/-",
                                style: TextStyle(fontSize: width / 25),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height / 40),
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
                    height: height / 25,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        return _onPayment(
                            args['product']['user']['email'], args['product']);
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
                    height: height / 40,
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
