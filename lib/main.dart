import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:teeshop/providers/auth.dart';
import 'package:teeshop/screens/about_us.dart';
import 'package:teeshop/screens/buy_now_custom_screen.dart';
import 'package:teeshop/screens/buy_now_screen.dart';
import 'package:teeshop/screens/contact_us.dart';
import 'package:teeshop/screens/customize_screen.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/screens/replacement.dart';
import 'package:teeshop/screens/signin_screen.dart';

import 'package:teeshop/widgets/app_drawer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      child: MaterialApp(
        title: 'TeeShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.purple,
          accentColor: Colors.purpleAccent,
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(brightness: Brightness.light),
        ),
        home: MyHomePage(),
        routes: {
          InfoScreen.routeName: (context) => InfoScreen(),
          BuyNowScreen.routeName: (context) => BuyNowScreen(),
          CustomizeScreen.routeName: (context) => CustomizeScreen(),
          BuyNowCustom.routeName: (context) => BuyNowCustom(),
          AboutUs.routeName: (context) => AboutUs(),
          ContactUs.routeName: (context) => ContactUs(),
          ReplacementScreen.routeName: (context) => ReplacementScreen(),
          SignInScreen.routeName: (context) => SignInScreen(),
        },
      ),
      providers: [
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      drawer: AppDrawer(),
      body: Provider.of<Auth>(context).getToken()
          ? ReplacementScreen()
          : SignInScreen(),
    );
  }
}
