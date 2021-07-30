import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  void _showErrorDialog(context, message, title, height, width) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: Colors.purple, fontSize: width / 20),
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

  var user_id;

  void update(userId) {
    user_id = userId;
  }

  Future<void> addOrder(
    BuildContext context,
    height,
    width, {
    int? product_id,
    int? qty,
    String? size,
    String? address,
    String selectedImage = '',
    String selectedColor = '',
    String text = '',
    double iconSize = 0,
    bool isIconPresent = false,
    bool isTextPresent = false,
    double angle = 0.0,
    int textSize = 0,
    double textRotation = 0.0,
    String textColor = '',
    String urlOne = '',
    String fontFamily = '',
    double iconX = 0.0,
    double iconY = 0.0,
    double textX = 0.0,
    double textY = 0.0,
    File? pickedFile,
    int price = 0,
  }) async {
    var url = 'https://teeshopindia.in/orders';
    Map<String, dynamic> bodyModel = {
      "user_id": user_id,
      "product_id": product_id,
      "size": size,
      "quantity": qty,
      "selected_image": selectedImage,
      "selected_color": selectedColor,
      "text": text,
      "icon_size": iconSize,
      "isIconPresent": isIconPresent,
      "isTextPresent": isTextPresent,
      "angle": angle,
      "textSize": textSize,
      "textRotation": textRotation,
      "textColor": textColor,
      "address": address,
      "url": urlOne,
      "font_family": fontFamily,
      "iconX": iconX,
      "iconY": iconY,
      "textX": textX,
      "textY": textY,
      "pickedFile": pickedFile.toString(),
      "price": price
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
        _showErrorDialog(context, response.data['message'].toString(),
            "Error :(", height, width);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> fetchOrders(BuildContext context, height, width) async {
    var url = 'https://teeshopindia.in/orders/$user_id';

    try {
      var dio = Dio();
      var response = await dio.get(
        url,
      );

      print(response.data);
      if (response.data['status'] == 401) {
        _showErrorDialog(context, response.data['message'].toString(),
            "Error :(", height, width);
        return;
      }

      return response.data;
    } catch (error) {
      print(error);
    }
  }
}
