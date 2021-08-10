import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:teeshop/providers/orders.dart';
import 'package:teeshop/providers/products.dart';
import 'package:teeshop/screens/your_profile_screen.dart';

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
  bool showChart = false;
  String? downLoadUrl = '';
  String dropdownValue = "";
  List<String> size = ["S", "M", "L", "XL", "XXL"];
  var args;
  var _isLoading = false;
  late Razorpay _razorpay;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args['product']['product']['user'].toString());

    print(args['_isIconPresent']);
    print(args['_isTextPresent']);
    // print("-------------------------------" +
    //     args['pickedFile'] +
    //     "---------------------------------");
    // print("-------------------------------" +
    //     args['selectedImage'].toString() +
    //     "---------------------------------");
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
                              style: TextStyle(fontSize: width / 25),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(fontSize: width / 25),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: pincodeEdit,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: width / 25),
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
        "email": args['product']['product']['user']['email'],
        "size": "$dropdownValue",
        "address": "$address",
        "quantity": "$quantity",
      },
    };

    try {
      _razorpay.open(options);
    } catch (error) {}
  }

  void handlerErrorFailure() {
    print('Error!!');
  }

  void handlerExternalWallet() {
    print('External Wallet');
  }

  Future<String?> uploadFile(filePath) async {
    File file = File(filePath);

    try {
      var snapShot = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('UserUploads/${DateTime.now().toString()}')
          .putFile(file);
      var gotUrl = await snapShot.ref.getDownloadURL();
      return gotUrl;
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg:
              'Something went wrong! Please try again Or contact the developer at ashmitteeshop@gmail.com',
          backgroundColor: Colors.red);
    }
  }

  void paySuccess(PaymentSuccessResponse r) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (args['pickedFile'] != null) {
        downLoadUrl = await uploadFile(args['pickedFile']);
        print('This is done');
      }

      await Provider.of<Order>(context, listen: false).addOrder(
        context,
        height,
        width,
        product_id: args['product']['product']['data']['id'],
        qty: quantity,
        size: dropdownValue,
        selectedImage: args['selectedImage'].toString(),
        selectedColor: args['selectedColor'].toString(),
        text: args['text'].toString(),
        iconSize: args['iconSize'],
        isIconPresent: args['_isIconPresent'],
        isTextPresent: args['_isTextPresent'],
        angle: args['angle'],
        textSize: args['textSize'].ceil(),
        textRotation: args['textRotation'],
        textColor: args['textColor'].toString(),
        address: args['address'].toString(),
        fontFamily: args['fontFamily'].toString(),
        iconX: args['iconX'],
        iconY: args['iconY'],
        textX: args['textX'],
        textY: args['textY'],
        pickedFile: downLoadUrl.toString() != ''
            ? downLoadUrl.toString()
            : 'File couldn\'t be uploaded contact user',
        urlOne: args["shirtShade"].toString(),
        price: args['product']['product']['data']['price'],
      );
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Order placed successfully!", backgroundColor: Colors.green);
    } catch (error) {
      print("------------------" +
          error.toString() +
          "----------------------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    total = args['price'] * quantity;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "BUY",
            style: TextStyle(fontSize: width / 25),
          ),
        ),
        body: _isLoading
            ? Center(
                child: SizedBox(
                  width: width / 10,
                  height: width / 10,
                  child: CircularProgressIndicator(),
                ),
              )
            : Builder(
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
                                args["shirtShade"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (args["selectedImage"] != null &&
                                  args["_isIconPresent"] != false &&
                                  args['pickedFile'] == null)
                                Positioned(
                                  top: args['iconY'] - 10,
                                  left: args['iconX'] - 10,
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
                              if (args["_isIconPresent"] != false &&
                                  args['pickedFile'] != null)
                                Positioned(
                                  top: args['iconY'] - 10,
                                  left: args['iconX'] - 10,
                                  child: Transform.rotate(
                                      angle: args["angle"],
                                      child: Image.file(
                                        args['selectedImage'],
                                        height: args['iconSize'],
                                      )),
                                ),
                              if (args["text"] != null &&
                                  args["_isTextPresent"] != false)
                                Positioned(
                                  top: args['textY'] - 10,
                                  left: args['textX'] - 10,
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
                        if (!args['product']['product']['data']['customizable'])
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
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: width / 25,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.all(width / 60),
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                      quantity.toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              width / 25)),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: width / 25,
                                                ),
                                              ),
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
                                        items: size
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        decoration: InputDecoration(
                                          labelText: 'Select Size',
                                          filled: true,
                                          labelStyle:
                                              TextStyle(fontSize: width / 25),
                                        ),
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
                              if (address != '' &&
                                  args['product']['product']['user']
                                          ['phone_verified'] !=
                                      false) {
                                return _onPayment(
                                    args['product']['product']['user']['email'],
                                    args['product']['product']);
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
                                          'You haven\'t selected an address for delivery. Or your Phone Number is not verified. If you have added it or changed it hit reload.',
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
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              Provider.of<Product>(context,
                                                      listen: false)
                                                  .products(context)
                                                  .then((value) {
                                                setState(() {
                                                  address =
                                                      value["user"]['address'];

                                                  _isLoading = false;
                                                });
                                                print(args['product']['product']
                                                    ['user']);
                                              });
                                            },
                                            child: Text('Reload'),
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
