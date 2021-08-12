import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/auth.dart';
import 'package:teeshop/providers/cart.dart';
import 'package:teeshop/providers/orders.dart';
import 'package:teeshop/providers/products.dart';
import 'package:teeshop/screens/about_us.dart';
import 'package:teeshop/screens/buy_now_custom_screen.dart';
import 'package:teeshop/screens/buy_now_screen.dart';
import 'package:teeshop/screens/contact_us.dart';
import 'package:teeshop/screens/customize_screen.dart';
import 'package:teeshop/screens/forgot_password.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/screens/order_cart_screen.dart';
import 'package:teeshop/screens/order_screen.dart';
import 'package:teeshop/screens/replacement.dart';
import 'package:teeshop/screens/signin_screen.dart';
import 'package:teeshop/screens/your_profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'TeeshopIndia',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.purple,
          accentColor: Colors.purpleAccent,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white),
          ),
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
          OrderScreen.routeName: (context) => OrderScreen(),
          OrderCartScreen.routeName: (context) => OrderCartScreen(),
          YourProfileScreen.routeName: (context) => YourProfileScreen(),
          ForgotPassword.routeName: (context) => ForgotPassword(),
        },
      ),
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Product>(
          create: (context) => Product(),
          update: (context, auth, previousResponse) =>
              previousResponse!..update(auth.userData),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (context) => Order(),
          update: (context, auth, previousResponse) =>
              previousResponse!..update(auth.userData),
        ),
        ChangeNotifierProxyProvider<Auth, Cart>(
          create: (context) => Cart(),
          update: (context, auth, previousResponse) =>
              previousResponse!..update(auth.userData),
        ),
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
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.purple,
        statusBarBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      // drawer: AppDrawer(),
      body: Provider.of<Auth>(context).getToken()
          ? ReplacementScreen()
          : SignInScreen(),
    );
  }
}
