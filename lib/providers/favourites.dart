import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teeshop/data/http_exception.dart';
import 'package:http/http.dart' as http;

class Favourites extends ChangeNotifier {
  int user_id = 0;

  void update(userId) {
    user_id = userId;
  }

  void _showErrorDialog(context, message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error!!',
              style: TextStyle(color: Colors.purple),
            ),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Future<void> addFavourites(
    BuildContext context, {
    int product_id = 0,
  }) async {
    var url = Uri.parse('https://teeshopindia.in/favourite');
    var response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {'user_id': user_id, 'product_id': product_id},
    );
    final responseData = json.decode(response.body);
    print(responseData);
    if (responseData['status'] == '401') {
      _showErrorDialog(context, responseData['errors'].toString());
    }
  }

  void removeFavourites(
    BuildContext context, {
    int id = 0,
  }) async {
    var url = Uri.parse('https://teeshopindia.in/favourite');
    var response = await http.delete(
      url,
      headers: {"Accept": "application/json"},
      body: {'id': id},
    );
    final responseData = json.decode(response.body);
    print(responseData);
    if (responseData['status'] == '401') {
      _showErrorDialog(context, responseData['errors'].toString());
    }
  }
}
