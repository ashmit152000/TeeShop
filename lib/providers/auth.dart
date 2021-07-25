import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teeshop/data/http_exception.dart';

class Auth with ChangeNotifier {
  int? _userId;
  String? _token;

  int? get userData {
    return _userId;
  }

  Future<void> login(BuildContext context,
      {String email = '', String password = ''}) async {
    var url = Uri.parse('https://teeshopindia.in/login');
    if (email != '' && password != '') {
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
        if (responseData['status'] == 401) {
          _showErrorDialog(context, responseData['message'].toString());
          return;
        }
        var getToken = await getAuthToken();
        _userId = int.parse(responseData['user']['id'].toString());
        _token = responseData['user']['auth_token'];

        await setAuthToken(_token!);

        notifyListeners();
      } catch (error) {
        throw HttpException(error.toString());
      }
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

  Future<dynamic> editUser(BuildContext context,
      {int? id,
      String? fullName,
      String? address,
      String? password,
      String? phoneNumber,
      String? email}) async {
    try {
      var dio = Dio();
      var url = 'https://teeshopindia.in/user/edit';
      Map<String, dynamic> bodyModel = {
        "id": id,
      };

      if (fullName != null) {
        bodyModel["full_name"] = fullName;
      }

      if (address != null) {
        bodyModel["address"] = address;
      }

      if (phoneNumber != null) {
        bodyModel["phone_number"] = phoneNumber;
      }

      if (email != null) {
        bodyModel["email"] = email;
      }

      if (password != null) {
        bodyModel["password"] = password;
      }

      final response = await dio.post(
        url,
        data: bodyModel,
        options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json),
      );

      Fluttertoast.showToast(
          msg: 'Account updated. Please hit reload from the bar');

      return response.data;
    } catch (error) {
      print(error);
    }
  }

  Future<void> token(BuildContext context) async {
    var url = Uri.parse('https://teeshopindia.in/login/token');
    try {
      var response = await http.post(
        url,
        headers: {"Accept": "application/json"},
        body: {'token': await getAuthToken()},
      );
      final responseData = json.decode(response.body);

      notifyListeners();
      if (responseData['status'] == 500) {
        _showErrorDialog(context, responseData['message'].toString());
        return;
      }

      _token = responseData['user']['auth_token'];

      _userId = int.parse(responseData['user']['id'].toString());
      notifyListeners();
    } catch (error) {
      // throw HttpException(error.toString());
      print(error);
    }
  }

  Future<dynamic> getUser(BuildContext context) async {
    var url = Uri.parse('https://teeshopindia.in/user/show/$_userId');
    try {
      var response = await http.get(
        url,
      );
      final responseData = json.decode(response.body);
      print(responseData);
      return responseData;
    } catch (error) {
      // throw HttpException(error.toString());
      print(error);
    }
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

      _token = responseData['user']['auth_token'];
      await setAuthToken(_token!);

      _userId = int.parse(responseData['user']['id'].toString());
      notifyListeners();
    } catch (error) {
      // throw HttpException(error.toString());
      print(error);
    }
  }

  // Future<void> updateUser() {}

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
      _token = null;
      await setAuthToken('');
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> sendVerification() async {
    var url = Uri.parse('https://teeshopindia.in/user/confirm/$_userId');
    try {
      var response = await http.post(url);
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool?> setAuthToken(String? token) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString("authToken", token!);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("authToken");
  }

  bool getToken() {
    if (_userId != null) {
      return true;
    } else {
      return false;
    }
  }
}
