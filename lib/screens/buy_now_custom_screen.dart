import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuyNowCustom extends StatefulWidget {
  @override
  _BuyNowCustomState createState() => _BuyNowCustomState();
  static const routeName = "/buy_now_custom";
}

class _BuyNowCustomState extends State<BuyNowCustom> {
  int quantity = 1;

  String dropdownValue = "M";
  List<String> size = ["S", "M", "L", "XL", "XXL"];
  String address =
      "QTR No. S/2, \n S-Block, \n Hudco Extension, \n Near Ansal Plaza, \n 110049, \n Delhi, New Delhi";
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var total = args['price'] * quantity;
    print(args);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("BUY"),
      ),
      body: Container(
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
                        Image.asset(args["url"]),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                        children: [
                          Text(
                            'Address: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                        gradient: LinearGradient(
                            colors: [Color(0xFF5f0a87), Color(0xFFa4508b)])),
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
    ));
  }
}
