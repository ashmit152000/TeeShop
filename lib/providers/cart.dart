import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teeshop/data/http_exception.dart';

class Cart with ChangeNotifier {
  var user_id;

  void _showErrorDialog(context, message, title, height, width) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: Colors.deepPurple, fontSize: width / 20),
            ),
            content: Text(
              message,
              style: TextStyle(fontSize: width / 25),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: width / 25),
                ),
              )
            ],
          );
        });
  }

  void update(userId) {
    user_id = userId;
  }

  Future<void> addCart(
      BuildContext context, product_id, height, width, image_url) async {
    try {
      var dio = Dio();
      var url = 'https://teeshopindia.in/cart';
      Map<String, dynamic> bodyModel = {
        "user_id": user_id,
        "product_id": product_id,
        "image_url": image_url,
      };
      final response = await dio.post(url,
          data: bodyModel,
          options: Options(
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json));
      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(context, response.data['errors'].toString(), 'Error!!',
            height, width);
      }

      if (response.data["status"] == 201) {
        _showErrorDialog(context, response.data['message'].toString(), "Alert",
            height, width);
      }
      if (response.data["status"] == 200) {
        _showErrorDialog(context, "Added to cart", "Done :)", height, width);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeCard(BuildContext context, int id, height, width) async {
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
        _showErrorDialog(context, response.data['message'].toString(), "Error!",
            height, width);
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> getCart(BuildContext context, height, width) async {
    try {
      var dio = Dio();
      var url = 'https://teeshopindia.in/carts/$user_id';

      final response = await dio.get(url);
      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(context, response.data['message'].toString(),
            "Error!!", height, width);
      }

      if (response.data["status"] == 500) {
        _showErrorDialog(context, response.data['message'].toString(), "Info",
            height, width);
      }

      return response.data;
    } catch (error) {
      print(error);
    }
  }
}
