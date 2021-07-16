import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/auth.dart';
import 'package:teeshop/providers/favourites.dart';
import 'package:teeshop/providers/orders.dart';
import 'package:teeshop/providers/products.dart';
import 'package:teeshop/screens/about_us.dart';
import 'package:teeshop/screens/buy_now_custom_screen.dart';
import 'package:teeshop/screens/buy_now_screen.dart';
import 'package:teeshop/screens/contact_us.dart';
import 'package:teeshop/screens/customize_screen.dart';
import 'package:teeshop/screens/favouritesscreen.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/screens/replacement.dart';
import 'package:teeshop/screens/signin_screen.dart';
import 'package:teeshop/widgets/app_drawer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          FavouritesScreen.routeName: (context) => FavouritesScreen(),
        },
      ),
      providers: [
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Favourites>(
          create: (context) => Favourites(),
          update: (context, auth, previousResponse) =>
              previousResponse!..update(auth.userData),
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Do you want to exit ?',
              style: TextStyle(color: Colors.purple),
            ),
            content: new Text('We were enjoying your time with us.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple,
      statusBarBrightness: Brightness.light,
    ));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: AppDrawer(),
        body: Provider.of<Auth>(context).getToken()
            ? ReplacementScreen()
            : SignInScreen(),
      ),
    );
  }
}
