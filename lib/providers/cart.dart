import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teeshop/data/http_exception.dart';

class Cart with ChangeNotifier {
  var user_id;

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

  void update(userId) {
    user_id = userId;
  }

  Future<void> addCart(BuildContext context, product_id) async {
    try {
      var dio = Dio();
      var url = 'https://teeshopindia.in/cart';
      Map<String, dynamic> bodyModel = {
        "user_id": user_id,
        "product_id": product_id
      };
      final response = await dio.post(url,
          data: bodyModel,
          options: Options(
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json));
      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(
            context, response.data['errors'].toString(), 'Error!!');
      }

      if (response.data["status"] == 201) {
        _showErrorDialog(context, response.data['message'].toString(), "Alert");
      }
      if (response.data["status"] == 200) {
        _showErrorDialog(context, "Added to cart", "Done :)");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeCard(BuildContext context, int id) async {
    try {
      var url = 'https://teeshopindia.in/cart/delete';
      var dio = Dio();
      Map<String, dynamic> bodyModel = {
        "id": id,
      };
      var response = await dio.delete(url,
          options: Options(
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json),
          data: bodyModel);
      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(
            context, response.data['message'].toString(), "Error!");
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> getCart(BuildContext context) async {
    try {
      var dio = Dio();
      var url = 'https://teeshopindia.in/carts/$user_id';

      final response = await dio.get(url);
      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(
            context, response.data['message'].toString(), "Error!!");
      }

      if (response.data["status"] == 500) {
        _showErrorDialog(context, response.data['message'].toString(), "Info");
      }

      return response.data;
    } catch (error) {
      print(error);
    }
  }
}
