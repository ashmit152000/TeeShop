import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  var user_id;

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
        _showErrorDialog(context, response.data['errors'].toString());
      }

      if (response.data["status"] == 201) {
        _showErrorDialog(context, response.data['message'].toString());
      }
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
        _showErrorDialog(context, response.data['errors'].toString());
      }

      if (response.data["status"] == 201) {
        _showErrorDialog(context, response.data['message'].toString());
      }

      return response.data;
    } catch (error) {
      print(error);
    }
  }
}
