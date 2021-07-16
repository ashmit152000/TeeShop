import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teeshop/data/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Favourites extends ChangeNotifier {
  var user_id;

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

  Future<void> addFavourites(BuildContext context, int product_id) async {
    try {
      var dio = Dio();
      var url = 'https://teeshopindia.in/favourite';
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
      if (response.data['status'] == '401') {
        _showErrorDialog(context, response.data['errors'].toString());
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> removeFavourites(BuildContext context, int product_id) async {
    try {
      var url = 'https://teeshopindia.in/favourite';
      var dio = Dio();
      Map<String, dynamic> bodyModel = {
        "user_id": user_id,
        "product_id": product_id
      };
      var response = await dio.delete(url,
          options: Options(
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json),
          data: bodyModel);
      print(response.data);
      if (response.data['status'] == '401') {
        _showErrorDialog(context, response.data['message'].toString());
      }
    } catch (error) {
      print(error);
    }
  }
}
