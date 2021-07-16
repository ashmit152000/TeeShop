import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Product with ChangeNotifier {
  var user_id;

  void update(userId) {
    print(userId.toString());
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

  Future<List<dynamic>> products(BuildContext context) async {
    var url = Uri.parse('https://teeshopindia.in/products/${user_id}');
    var response = await http.get(
      url,
    );
    final responseData = json.decode(response.body);
    print(responseData);
    if (responseData['status'] == '401') {
      _showErrorDialog(context, responseData['message'].toString());
    }

    return responseData['products'];
  }
}
