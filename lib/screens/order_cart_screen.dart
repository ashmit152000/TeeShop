import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/cart.dart';
import 'package:teeshop/screens/info_screen.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class OrderCartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _OrderCartScreenState createState() => _OrderCartScreenState();
}

class _OrderCartScreenState extends State<OrderCartScreen> {
  var cart = [];
  var products = [];
  var _isLoading = false;
  var _userData;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      _isLoading = true;
    });
    Provider.of<Cart>(context).getCart(context).then((value) {
      setState(() {
        _userData = value["user "] != null ? value["user"] : {};
        cart = value["cart"] != null ? List.from(value["cart"]) : [];
        products =
            value["products"] != null ? List.from(value["products"]) : [];
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  Widget cartGrid() {
    return products.isNotEmpty
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("Pressed $index");
                  Navigator.of(context).pushReplacementNamed(
                      InfoScreen.routeName,
                      arguments: {"data": products[index], "user": _userData});
                },
                child: GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(products[index]['url']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black87,
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Text(
                          products[index]['name'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                    ),
                  ),
                ),
              );
            },
            itemCount: products.length,
          )
        : Center(
            child: Card(
              elevation: 8,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'No items yet!!',
                  style: TextStyle(color: Colors.purple, fontSize: 20),
                ),
              ),
            ),
          );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Do you want to exit ?',
              style: TextStyle(color: Colors.purple),
            ),
            content: new Text('We were enjoying your time wit us.'),
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            title: Text('Cart'),
          ),
          body: Container(
            child: _isLoading != true
                ? cartGrid()
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            padding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
