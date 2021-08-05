import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var height;
  var width;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    setState(() {
      _isLoading = true;
    });
    Provider.of<Cart>(context).getCart(context, height, width).then((value) {
      setState(() {
        _userData = value["user"] != null ? value["user"] : {};
        cart = value["cart"] != null ? List.from(value["cart"]) : [];
        products =
            value["products"] != null ? List.from(value["products"]) : [];
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  Widget cartGrid(height, width) {
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
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/product-placeholder.png'),
                      image: NetworkImage(cart[index]['image_url'].toString()),
                      fit: BoxFit.cover,
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
                      onPressed: () async {
                        print(cart[index]['id']);
                        await Provider.of<Cart>(context, listen: false)
                            .removeCard(
                                context, cart[index]['id'], height, width);
                        Fluttertoast.showToast(
                            msg: 'Product removed from cart',
                            fontSize: width / 25);

                        // setState(() {});
                      },
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

  // Is java a pure object oriented language ? If yes, how. If no, then why ?

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Container(
          child: _isLoading != true
              ? cartGrid(height, width)
              : Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: width / 10,
                    width: width / 10,
                  ),
                ),
          padding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
