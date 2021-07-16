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
        orders = List.from(value["orders"]);
        products = List.from(value["products"]);
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  Widget getList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        var date = DateFormat('dd MMMM yyyy')
            .format(DateTime.parse(orders[index]["created_at"]));
        return Container(
          padding: EdgeInsets.all(10),
          child: ListTile(
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
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "QTY: " + orders[index]['quantity'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'Amount:  ₹${orders[index]['quantity'] * products[index]['price']}')
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: products.length,
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
