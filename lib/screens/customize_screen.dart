import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:teeshop/screens/buy_now_custom_screen.dart';
import 'package:permission_handler/permission_handler.dart';

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
  var height;
  var width;
  final _picker = ImagePicker();
  bool _isTextPresent = false;
  bool _isLogoPresent = true;
  var angle = 0.0;
  var textSize = 15.0;
  var textRotation = 0.0;
  var text = 'TeeShop';
  var textColor = Colors.black;
  var top;
  var left;
  var pathImage;
  var topText;
  var leftText;
  var _productData;
  bool textClicked = false;

  var _isLoading = false;
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
    if (await Permission.photos.request().isGranted) {
      final XFile? picked = await _picker.pickImage(source: source);
      if (picked != null) {
        setState(() {
          _pickedImage = picked;
        });
      }

      try {
        if (_pickedImage != null) {
          croppedFile = await ImageCropper.cropImage(
              sourcePath: _pickedImage.path,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
              ],
              compressQuality: 100,
              maxWidth: 200,
              maxHeight: 200,
              compressFormat: ImageCompressFormat.png,
              androidUiSettings: AndroidUiSettings(
                toolbarColor: Colors.purple,
                toolbarTitle: 'TeeShop Cropper',
                backgroundColor: Colors.white,
              ));
          print(croppedFile.toString());
          setState(() {
            selectedFile = croppedFile;
            pathImage = croppedFile.path;
          });
        } else {
          _pickedImage = null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      _loadPicker(source);
    }
  }

  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(
        msg:
            'You can slide, reposition, change and edit the Icon above from the toolbar at the bottom',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.blue);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    left = width * 0.5;
    top = height / 1.5 * 0.5;
    leftText = width * 0.5;
    topText = height / 1.5 * 0.5;
    setState(() {
      _isLoading = true;
    });
    _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Image.network(_productData['product']['data']['related_products'][0])
        .image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Customise',
              style: TextStyle(fontSize: width / 25),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  print(top.toString());
                  Navigator.of(context)
                      .pushNamed(BuyNowCustom.routeName, arguments: {
                    "selectedImage":
                        _pickedImage != null ? selectedFile : selectedImage,
                    "selectedColor": selectedColor,
                    "shirtShade": _productData['selectedImage'],
                    "text": text,
                    "iconSize": iconSize,
                    "_isIconPresent": _isLogoPresent,
                    "_isTextPresent": _isTextPresent,
                    "angle": angle,
                    "textSize": textSize,
                    "textRotation": textRotation,
                    "textColor": textColor,
                    "price": 399,
                    "address": _productData['product']['user']['address'],
                    "url": _productData['product']['data']['url'],
                    "related_products": _productData['product']['data']
                        ['related_products'],
                    "fontFamily": fontFamilySelector,
                    "name": _productData['product']['data']['name'],
                    "product": _productData,
                    "user": _productData['product']['user'],
                    "iconX": left,
                    "iconY": top,
                    "textX": leftText,
                    "textY": topText,
                    "pickedFile": pathImage,
                  });
                },
                child: Text(
                  'Select',
                  style: TextStyle(color: Colors.white, fontSize: width / 25),
                ),
              ),
            ]),
        body: _isLoading
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: width / 10,
                  width: width / 10,
                ),
              )
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: double.infinity,
                          child: GestureDetector(
                            onVerticalDragUpdate: (dd) {
                              setState(() {
                                if (textClicked == false) {
                                  top = dd.localPosition.dy;
                                  left = dd.localPosition.dx;
                                } else {
                                  topText = dd.localPosition.dy;
                                  leftText = dd.localPosition.dx;
                                }
                              });
                            },
                            child: Stack(
                              fit: StackFit.loose,
                              clipBehavior: Clip.antiAlias,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: height / 1.5,
                                  child: Image.network(
                                    _productData['selectedImage'].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (_isLogoPresent &&
                                    _pickedImage == null &&
                                    selectedFile == null)
                                  Positioned(
                                    top: top,
                                    left: left,
                                    child: GestureDetector(
                                      onTapDown: (dd) {
                                        setState(() {
                                          textClicked = false;
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
                                if (_isLogoPresent &&
                                    _pickedImage != null &&
                                    selectedFile != null)
                                  Positioned(
                                    top: top,
                                    left: left,
                                    child: GestureDetector(
                                      onTapDown: (dd) {
                                        setState(() {
                                          textClicked = false;
                                        });
                                      },
                                      child: Transform.rotate(
                                        angle: (pi / 4) * angle,
                                        child: Image.file(
                                          selectedFile,
                                          height: iconSize.toDouble(),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_isTextPresent)
                                  Positioned(
                                    top: topText,
                                    left: leftText,
                                    child: GestureDetector(
                                      onTapDown: (dd) {
                                        setState(() {
                                          textClicked = true;
                                        });
                                      },
                                      child: Transform.rotate(
                                        angle: (pi / 4) * textRotation,
                                        child: Text(
                                          text.toString(),
                                          style: TextStyle(
                                              fontSize: textSize,
                                              fontFamily: fontFamilySelector,
                                              color: textColor),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
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
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 25),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'CUSTOMIZE ICON',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 25),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'TEXT',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 25),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'CUSTOMIZE TEXT',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 25),
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
                                    padding: EdgeInsets.all(10),
                                    child: customize()),
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
          label: Text(
            'Upload Icon',
            style: TextStyle(fontSize: width / 25),
          ),
          onPressed: () {
            _loadPicker(ImageSource.gallery);
          },
        ),
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width / 25),
                    ),
                    SizedBox(
                      width: width / 25,
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
                        height: width / 10,
                        width: width / 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('ICON SIZE: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width / 25)),
                    SizedBox(
                      width: width / 25,
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
                          width: width / 2.5,
                          child: Slider(
                              min: 20,
                              max: width / 3,
                              value: iconSize,
                              inactiveColor: Colors.grey,
                              onChanged: (newVal) {
                                setState(() {
                                  iconSize = newVal;
                                });
                              }),
                        )),
                  ],
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    Text(
                      'ROTATE: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width / 25),
                    ),
                    SizedBox(
                      width: width / 25,
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
                            size: width / 5,
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width / 25),
                    ),
                    SizedBox(
                      width: width / 25,
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
                        height: width / 10,
                        width: width / 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  children: [
                    Text(
                      'TEXT SIZE: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width / 25),
                    ),
                    SizedBox(
                      width: width / 25,
                    ),
                    Container(
                      width: width / 2.5,
                      child: Slider(
                          min: 5,
                          max: width / 10,
                          value: textSize,
                          inactiveColor: Colors.grey,
                          onChanged: (newVal) {
                            setState(() {
                              textSize = newVal;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    Text(
                      'FONT FAMILY: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width / 25),
                    ),
                    SizedBox(
                      width: width / 25,
                    ),
                    Expanded(
                      child: Container(
                        child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.purple,
                            decoration: InputDecoration(
                              labelText: "Choose Font",
                              labelStyle: TextStyle(
                                  color: Colors.white, fontSize: width / 25),
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
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width / 40),
                                  ));
                            }).toList()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 50),
                Row(
                  children: [
                    Text(
                      'ROTATE: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width / 25),
                    ),
                    SizedBox(
                      width: width / 25,
                    ),
                    SleekCircularSlider(
                        min: 0,
                        max: 8,
                        appearance: CircularSliderAppearance(
                          size: width / 5,
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
    Colors.white,
    Colors.amber,
    Colors.cyan,
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
          fontSize: width / 25,
        ),
      ),
      Switch(
          value: _isLogoPresent,
          onChanged: (newValue) {
            setState(() {
              _isLogoPresent = newValue;
              top = height / 1.5 * 0.5;
              left = width / 2;
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
                  _pickedImage = null;
                  selectedFile = null;
                  pathImage = null;
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
            Center(
              child: Text(
                'WANT TEXT ? ',
                style: TextStyle(color: Colors.white, fontSize: width / 25),
              ),
            ),
            Switch(
                value: _isTextPresent,
                onChanged: (newValue) {
                  setState(() {
                    _isTextPresent = newValue;
                    topText = height / 1.5 * 0.5;
                    leftText = width / 2;
                  });
                }),
          ]),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white, fontSize: width / 25),
            controller: textPrintController,
            decoration: InputDecoration(
              labelText: "Enter Text",
              labelStyle: TextStyle(color: Colors.white, fontSize: width / 25),
            ),
            onChanged: (newVal) {
              setState(() {
                text = newVal;
              });
            },
          ),
          SizedBox(
            height: height / 50,
          ),
          Text(
            'NOTE: IF THE TEXT CROSSES THE BORDERS OF THE SHIRT HERE, WE WILL MAKE IT MULTILINE IN THE ACTUAL PRINT.',
            style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: width / 25),
          ),
          SizedBox(
            height: height / 50,
          ),
        ]),
      ),
    );
  }
}
