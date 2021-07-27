import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuyNowCustom extends StatefulWidget {
  @override
  _BuyNowCustomState createState() => _BuyNowCustomState();
  static const routeName = "/buy_now_custom";
}

class _BuyNowCustomState extends State<BuyNowCustom> {
  int quantity = 1;
  var address;
  String dropdownValue = "M";
  List<String> size = ["S", "M", "L", "XL", "XXL"];
  var args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    address = args['address'];
  }

  TextEditingController addressEdit = TextEditingController();
  TextEditingController pincodeEdit = TextEditingController();
  GlobalKey<FormState> pincodeKey = GlobalKey();
  void showBottomSheetView(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: EdgeInsets.all(10),
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
                                address =
                                    addressEdit.text + "\n" + pincodeEdit.text;
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
                          child: Text('Done'),
                        ),
                      ])
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var total = args['price'] * quantity;

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
                  Card(
                    elevation: 8,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(args["related_products"]),
                            Column(
                              children: [
                                if (args["selectedImage"] != null &&
                                    args["_isIconPresent"] != false)
                                  Transform.rotate(
                                    angle: args["angle"],
                                    child: SvgPicture.asset(
                                      args['selectedImage'],
                                      height: args["iconSize"].toDouble(),
                                      colorBlendMode: BlendMode.srcATop,
                                      allowDrawingOutsideViewBox: false,
                                      color: args['selectedColor'],
                                    ),
                                  ),
                                if (args["text"] != null &&
                                    args["_isTextPresent"] != false)
                                  Transform.rotate(
                                    angle: args["textRotation"],
                                    child: Text(
                                      args["text"],
                                      style: TextStyle(
                                          fontSize: args["textSize"],
                                          fontFamily: args["fontFamily"],
                                          color: args["textColor"]),
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          child: Text(
                            args['name'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '₹${args['price']}/-',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'QTY: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
