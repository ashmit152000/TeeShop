import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teeshop/data/http_exception.dart';

class Auth with ChangeNotifier {
  var _userId;

  int get userData {
    return _userId;
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    var url = Uri.parse('https://teeshopindia.in/login');
    try {
      var response = await http.post(
        url,
        headers: {"Accept": "application/json"},
        body: {
          'email': email,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);

      if (responseData['status'] == 401) {
        _showErrorDialog(context, responseData['message'].toString());
        return;
      }
      _userId = int.parse(responseData['user']['id'].toString());
      print(_userId.runtimeType);
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
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

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    var url = Uri.parse('https://teeshopindia.in/users');
    try {
      var response = await http.post(
        url,
        headers: {"Accept": "application/json"},
        body: {
          'email': email,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == 500) {
        _showErrorDialog(context, responseData['message'].toString());
        return;
      }
      _userId = int.parse(responseData['user']['id'].toString());
      print(_userId.runtimeType);
      notifyListeners();
    } catch (error) {
      // throw HttpException(error.toString());
      print(error);
    }
  }

  Future<void> logout() async {
    var url = Uri.parse('https://teeshopindia.in/logout');
    try {
      var response = await http.delete(url);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == 401) {
        throw HttpException(responseData['message']);
      }
      _userId = null;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  bool getToken() {
    if (_userId != null) {
      return true;
    } else {
      return false;
    }
  }
}
