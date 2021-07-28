import 'package:flutter/material.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/about-us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A big wave to all our customers. We are the Teeshop team. A team of professional Graphic designer, Developers and Designers. Who are always keen to work and provide our customers with the best quality customised merchandise as well as services  on clothing and designing. We here provide you to connect with us in a very efficient, modern and creative way. This App is created for all our paramount customers. In doing so, we can proudly say that, we haven\'t just cared about our customers expectations, which has always been prime for us, but we have also proudly lived upto their expectations with our services and never compromising quality control on our product. Here we are providing you, our customers AKA omnipotent as considered in our culture, with gamut of product range including stuff like Cotton shirts, Hoodies, Full sleeves, with all kind of customisation from icon to text, color to font and provided to uploaded icons according to your wishes and choices.',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'THANK YOU ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Courgette',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'From The 3As(Ashmit, Arzoo & Anirudh) and The TeeShop Team',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Courgette',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
