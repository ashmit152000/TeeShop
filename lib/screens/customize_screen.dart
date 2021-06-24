import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomizeScreen extends StatefulWidget {
  static const routeName = '\customize';
  @override
  _CustomizeScreenState createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  var selectedImage = 'assets/svgs/ironman.svg';
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _productData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(15),
                  child: CarouselSlider.builder(
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.3,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  _productData['data']['url'],
                                                ))),
                                      ),
                                    if (pageViewIndex == 1)
                                      SvgPicture.asset(
                                        selectedImage,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        colorBlendMode: BlendMode.srcATop,
                                        allowDrawingOutsideViewBox: false,
                                      ),
                                    if (pageViewIndex == 0)
                                      SvgPicture.asset(
                                        selectedImage,
                                        height: 300,
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
                      ))),
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
                            actions: [
                              // Padding(
                              //     padding: EdgeInsets.only(right: 10),
                              //     child: GestureDetector(
                              //       onTap: () {
                              //         setState(() {});
                              //       },
                              //     )),
                            ],
                            title: TabBar(
                              tabs: [
                                Tab(
                                    child: Text(
                                  'ICONS',
                                  style: TextStyle(color: Colors.white),
                                )),
                                Tab(
                                  child: Text(
                                    'OPTIONS',
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
                      Text('OPTIONS', style: TextStyle(color: Colors.white)),
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

  // {
  //   "image":
  //       'https://www.nationsonline.org/gallery/Switzerland/Sunrise-on-the-Matterhorn.jpg',
  //   'clicked': false
  // },
  // {
  //   "image":
  //       'https://www.nationsonline.org/gallery/Switzerland/Sunrise-on-the-Matterhorn.jpg',
  //   'clicked': false
  // },
  // {
  //   "image":
  //       'https://img.emg-services.net/HtmlPages/HtmlPage4239/switzerland-header-2.jpg',
  //   'clicked': false
  // },
  // {
  //   "image":
  //       'https://s30876.pcdn.co/wp-content/uploads/Switzerland-1170x630.jpg',
  //   'clicked': false
  // },
  // {
  //   'image':
  //       'https://www.planetware.com/photos-large/CH/switzerland-matterhorn.jpg',
  //   'clicked': false
  // },
  // {
  //   'image':
  //       'https://lp-cms-production.imgix.net/features/2017/08/shutterstock_611229743-bde2e023e33c.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850',
  //   'clicked': false
  // },
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
              print(wallpaperCollection[index]['clicked']);
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
