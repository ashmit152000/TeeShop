import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/orders.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var orders = [];
  var products = [];
  var _isLoading = false;
  var ordersPresent;
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      _isLoading = true;
    });
    Provider.of<Order>(context).fetchOrders(context).then((value) {
      setState(() {
        ordersPresent = value["orders"] != null ? true : false;
        orders = value["orders"] != null ? List.from(value["orders"]) : [];
        products =
            value["products"] != null ? List.from(value["products"]) : [];
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  bool showDesc = false;

  Widget getList() {
    return orders.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              var date = DateFormat('dd MMMM yyyy')
                  .format(DateTime.parse(orders[index]["created_at"]));
              return Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      orders[index]['showDesc'] = !orders[index]['showDesc'];
                    });
                    print(showDesc);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index]["name"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(date),
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Amount:'),
                            Text(
                                '₹${orders[index]['quantity'] * products[index]['price']}')
                          ],
                        ),
                        trailing: Icon(orders[index]['showDesc']
                            ? Icons.expand_less
                            : Icons.expand_more),
                      ),
                      if (orders[index]['showDesc']) Divider(),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: orders[index]["showDesc"] ? 200 : 0,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                products[index]['url'],
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Size: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(orders[index]["size"])
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Quantity: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(orders[index]["quantity"].toString())
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Description Short: ' +
                                  products[index]['descShort'].toString())
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: products.length,
          )
        : Center(
            child: Card(
              elevation: 8,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'No orders yet!!',
                  style: TextStyle(color: Colors.purple, fontSize: 20),
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            title: Text('Orders'),
          ),
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : getList(),
        ),
      ),
    );
  }
}
