import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:teeshop/screens/buy_now_custom_screen.dart';

class CustomizeScreen extends StatefulWidget {
  static const routeName = '\customize';
  @override
  _CustomizeScreenState createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  String selectedImage = 'assets/svgs/ironman.svg';
  var selectedColor = Colors.transparent;
  TextEditingController textPrintController = TextEditingController();
  var iconSize = 50.0;
  var _pickedImage;
  var croppedFile;
  var selectedFile;
  final _picker = ImagePicker();
  bool _isTextPresent = false;
  bool _isLogoPresent = true;
  var angle = 0.0;
  var textSize = 15.0;
  var textRotation = 0.0;
  var text = 'TeeShop';
  var textColor = Colors.black;
  var top = 0.0;
  var left = 0.0;
  var wallpaperCollection = [
    {"image": "assets/svgs/ironman.svg", "clicked": false, "id": "1"},
    {"image": "assets/svgs/flash.svg", "clicked": false, "id": "2"},
    {"image": "assets/svgs/likeboss.svg", "clicked": false, "id": "3"},
    {"image": "assets/svgs/marvel.svg", "clicked": false, "id": "4"},
    {"image": "assets/svgs/bat.svg", "clicked": false, "id": "7"},
    {"image": "assets/svgs/jokercard.svg", "clicked": false, "id": "8"},
    {"image": "assets/svgs/bee.svg", "clicked": false, "id": "9"},
    {"image": "assets/svgs/fish.svg", "clicked": false, "id": "10"},
    {"image": "assets/svgs/joker.svg", "clicked": false, "id": "11"},
    {"image": "assets/svgs/kakashi.svg", "clicked": false, "id": "12"},
    {"image": "assets/svgs/fingerprint.svg", "clicked": false, "id": "13"},
  ];

  var fontFamilyName = [
    "Roboto",
    "BigShoulder",
    "Courgette",
    "DancingScript",
    "Gloria",
    "Jomhuria",
    "Right",
    "Sacra",
    "Staatliches",
    "Yellowtail",
  ];

  var fontFamilySelector = "Roboto";

  _loadPicker(ImageSource source) async {
    final PickedFile? picked = await _picker.getImage(source: source);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }

    try {
      if (_pickedImage != null) {
        croppedFile = await ImageCropper.cropImage(
            sourcePath: _pickedImage.path,
            aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
            compressQuality: 100,
            maxWidth: 700,
            maxHeight: 700,
            compressFormat: ImageCompressFormat.jpg,
            androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.orange,
              toolbarTitle: 'TeeShop Cropper',
              backgroundColor: Colors.white,
            ));

        setState(() {
          selectedFile = croppedFile;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Customise'), actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(BuyNowCustom.routeName, arguments: {
              "selectedImage": selectedImage,
              "selectedColor": selectedColor,
              "text": text,
              "iconSize": iconSize,
              "_isIconPresent": _isLogoPresent,
              "_isTextPresent": _isTextPresent,
              "angle": angle,
              "textSize": textSize,
              "textRotation": textRotation,
              "textColor": textColor,
              "price": 399,
              "url": _productData['data']['url'],
              "fontFamily": fontFamilySelector,
              "name": _productData['data']['name'],
            });
          },
          child: Text(
            'SELECT',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ]),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: CarouselSlider.builder(
                  itemCount: 2,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Card(
                      elevation: 8,
                      child: Stack(
                        children: [
                          if (pageViewIndex == 1)
                            Container(
                              height: MediaQuery.of(context).size.height / 2.3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    _productData['data']['url'],
                                  ),
                                ),
                              ),
                            ),
                          Column(
                            children: [
                              if (pageViewIndex == 1 &&
                                  _isLogoPresent &&
                                  _pickedImage != null)
                                Transform.rotate(
                                  angle: (pi / 4) * angle,
                                  child: Image.file(
                                    selectedFile,
                                    height: iconSize.toDouble(),
                                  ),
                                ),
                              if (pageViewIndex == 1 && _isTextPresent)
                                Transform.rotate(
                                  angle: (pi / 4) * textRotation,
                                  child: Text(
                                    text.toString(),
                                    style: TextStyle(
                                        fontSize: textSize,
                                        fontFamily: fontFamilySelector,
                                        color: textColor),
                                  ),
                                ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (pageViewIndex == 0 &&
                                  _isLogoPresent &&
                                  _pickedImage == null)
                                SvgPicture.asset(
                                  selectedImage,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  color: selectedColor,
                                  colorBlendMode: BlendMode.srcATop,
                                  allowDrawingOutsideViewBox: false,
                                ),
                              if (pageViewIndex == 0 &&
                                  _isLogoPresent &&
                                  _pickedImage != null)
                                Image.file(
                                  selectedFile,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                ),
                              if (pageViewIndex == 0 && _isTextPresent)
                                Center(
                                  child: Text(
                                    text.toString(),
                                    style: TextStyle(
                                        color: textColor,
                                        fontFamily: fontFamilySelector,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                30),
                                  ),
                                ),
                            ],
                          ),
                          if (pageViewIndex == 1 &&
                              _isLogoPresent &&
                              _pickedImage == null)
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 1),
                              top: top,
                              left: left,
                              child: GestureDetector(
                                onVerticalDragStart: (details) {
                                  setState(() {
                                    top = top;
                                    left = left;
                                  });
                                },
                                onVerticalDragUpdate: (DragUpdateDetails dd) {
                                  setState(() {
                                    top = dd.localPosition.dy;
                                    left = dd.localPosition.dx;
                                  });
                                },
                                child: Transform.rotate(
                                  angle: (pi / 4) * angle,
                                  child: SvgPicture.asset(
                                    selectedImage,
                                    height: iconSize.toDouble(),
                                    colorBlendMode: BlendMode.srcATop,
                                    allowDrawingOutsideViewBox: false,
                                    color: selectedColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 2,
                    enableInfiniteScroll: false,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                color: Colors.black,
                child: DefaultTabController(
                  length: 4,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        PreferredSize(
                          child: SliverAppBar(
                            automaticallyImplyLeading: false,
                            title: TabBar(
                              isScrollable: true,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'ICONS',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'CUSTOMIZE ICON',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'TEXT',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'CUSTOMIZE TEXT',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.black,
                          ),
                          preferredSize: Size.fromHeight(0),
                        )
                      ];
                    },
                    body: TabBarView(
                      children: [
                        wallpapers(),
                        Padding(
                            padding: EdgeInsets.all(10), child: customize()),
                        textPrint(),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: customizeText()),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Upload Icon'),
        onPressed: () {
          _loadPicker(ImageSource.gallery);
        },
      ),
    );
  }

  Widget customize() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'COLOR: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return getGrid();
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: selectedColor),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'ICON SIZE: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return getGrid();
                              });
                        },
                        child: Slider(
                            min: 20,
                            max: 70,
                            value: iconSize,
                            inactiveColor: Colors.grey,
                            onChanged: (newVal) {
                              setState(() {
                                iconSize = newVal;
                              });
                            })),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'ROTATE: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return getGrid();
                            });
                      },
                      child: SleekCircularSlider(
                          min: 0,
                          max: 8,
                          appearance: CircularSliderAppearance(
                            size: 100,
                            infoProperties: InfoProperties(
                              mainLabelStyle: TextStyle(color: Colors.black),
                            ),
                            customWidths: CustomSliderWidths(handlerSize: 0),
                          ),
                          initialValue: angle,
                          onChange: (newVal) {
                            setState(() {
                              angle = newVal;
                            });
                            print(angle);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customizeText() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'COLOR: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return getGridText();
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: textColor),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'TEXT SIZE: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Slider(
                        min: 5,
                        max: 20,
                        value: textSize,
                        inactiveColor: Colors.grey,
                        onChanged: (newVal) {
                          setState(() {
                            textSize = newVal;
                          });
                        }),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'FONT FAMILY: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.purple,
                            decoration: InputDecoration(
                              labelText: "Choose Font",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                fontFamilySelector = newValue.toString();
                              });
                            },
                            items: fontFamilyName
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }).toList()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'ROTATE: ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    SleekCircularSlider(
                        min: 0,
                        max: 8,
                        appearance: CircularSliderAppearance(
                          size: 100,
                          infoProperties: InfoProperties(
                            mainLabelStyle: TextStyle(color: Colors.black),
                          ),
                          customWidths: CustomSliderWidths(handlerSize: 0),
                        ),
                        initialValue: angle,
                        onChange: (newVal) {
                          setState(() {
                            textRotation = newVal;
                          });
                          print(angle);
                        }),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  final colorList = [
    Colors.blue,
    Colors.pink,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.red,
    Colors.teal,
    Colors.lime,
    Colors.black,
  ];

  Widget getGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4 / 5,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = colorList[index];
              Navigator.of(context).pop();
            });
          },
          child: Container(
            color: colorList[index],
          ),
        );
      },
      itemCount: colorList.length,
    );
  }

  Widget getGridText() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4 / 5,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              textColor = colorList[index];
              Navigator.of(context).pop();
            });
          },
          child: Container(
            color: colorList[index],
          ),
        );
      },
      itemCount: colorList.length,
    );
  }

  Widget wallpapers() {
    return Column(children: [
      Text(
        'WANT ICON ? ',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      Switch(
          value: _isLogoPresent,
          onChanged: (newValue) {
            setState(() {
              _isLogoPresent = newValue;
            });
          }),
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedImage =
                      wallpaperCollection[index]["image"].toString();

                  for (int i = 0; i < wallpaperCollection.length; i++) {
                    wallpaperCollection[i]['clicked'] = false;
                  }
                  wallpaperCollection[index]['clicked'] = true;
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                child: Container(
                  decoration: BoxDecoration(
                    border: wallpaperCollection[index]['clicked'] != false
                        ? Border.all(color: Colors.white, width: 3)
                        : Border.all(color: Colors.transparent),
                  ),
                  child: GridTile(
                    child: SvgPicture.asset(
                      wallpaperCollection[index]['image'].toString(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: wallpaperCollection.length,
        ),
      ),
    ]);
  }

  Widget textPrint() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(children: [
          Row(children: [
            Text(
              'WANT TEXT ? ',
              style: TextStyle(color: Colors.white),
            ),
            Switch(
                value: _isTextPresent,
                onChanged: (newValue) {
                  setState(() {
                    _isTextPresent = newValue;
                  });
                }),
          ]),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: textPrintController,
            decoration: InputDecoration(
                labelText: "Enter Text",
                labelStyle: TextStyle(color: Colors.white)),
            onChanged: (newVal) {
              setState(() {
                text = newVal;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              'NOTE: IF THE TEXT CROSSES THE BORDERS OF THE SHIRT HERE, WE WILL MAKE IT MULTILINE IN THE ACTUAL PRINT.',
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
