import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  void _showErrorDialog(context, message, title) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
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

  var user_id;

  void update(userId) {
    user_id = userId;
  }

  Future<void> addOrder(
      BuildContext context, int product_id, int qty, String size) async {
    var url = 'https://teeshopindia.in/orders';
    Map<String, dynamic> bodyModel = {
      "user_id": user_id,
      "product_id": product_id,
      "size": size,
      "quantity": qty
    };
    try {
      var dio = Dio();
      var response = await dio.post(
        url,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json),
        data: bodyModel,
      );

      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(
            context, response.data['message'].toString(), "Error :(");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> fetchOrders(BuildContext context) async {
    var url = 'https://teeshopindia.in/orders/$user_id';

    try {
      var dio = Dio();
      var response = await dio.get(
        url,
      );

      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(
            context, response.data['message'].toString(), "Error :(");
        return;
      }

      return response.data;
    } catch (error) {
      print(error);
    }
  }
}
