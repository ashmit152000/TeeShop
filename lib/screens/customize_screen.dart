import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomizeScreen extends StatefulWidget {
  static const routeName = '\customize';
  @override
  _CustomizeScreenState createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  String selectedImage = 'assets/svgs/ironman.svg';
  var selectedColor = Colors.transparent;
  var iconSize = 50.0;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Customize'), actions: [
        TextButton(
          onPressed: () {},
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
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (pageViewIndex == 1)
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          _productData['data']['url'],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (pageViewIndex == 1)
                                  SvgPicture.asset(
                                    selectedImage,
                                    height: iconSize.toDouble(),
                                    colorBlendMode: BlendMode.srcATop,
                                    allowDrawingOutsideViewBox: false,
                                    color: selectedColor,
                                  ),
                                if (pageViewIndex == 0)
                                  SvgPicture.asset(
                                    selectedImage,
                                    height: 300,
                                    color: selectedColor,
                                    colorBlendMode: BlendMode.srcATop,
                                    allowDrawingOutsideViewBox: false,
                                  ),
                              ],
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
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        PreferredSize(
                          child: SliverAppBar(
                            automaticallyImplyLeading: false,
                            title: TabBar(
                              tabs: [
                                Tab(
                                  child: Text(
                                    'ICONS',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'CUSTOMIZE',
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
                    body: TabBarView(children: [
                      wallpapers(),
                      Padding(padding: EdgeInsets.all(10), child: customize()),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customize() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
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
                      max: 100,
                      value: iconSize,
                      inactiveColor: Colors.grey,
                      onChanged: (newVal) {
                        setState(() {
                          iconSize = newVal;
                        });
                      }),
                ),
              ],
            )
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
    Colors.cyanAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.green,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.red,
    Colors.teal
  ];

  Widget getGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
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

  Widget wallpapers() {
    var wallpaperCollection = [
      {"image": "assets/svgs/ironman.svg", "clicked": false},
      {"image": "assets/svgs/flash.svg", "clicked": false},
    ];
    return GridView.builder(
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
              selectedImage = wallpaperCollection[index]["image"].toString();
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
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: wallpaperCollection.length,
    );
  }
}
