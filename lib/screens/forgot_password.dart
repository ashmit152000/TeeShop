import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/auth.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot-pass';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var height;
  var width;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> gKey = GlobalKey();
  var _isLoading = false;
  var authValue = {
    "email": "",
    "password": "",
  };
  void _onSaved() async {
    bool valid = gKey.currentState!.validate();

    if (!valid) {
      return;
    }
    gKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Auth>(context, listen: false).forgotPassword(
        context,
        height,
        width,
        authValue['email'].toString(),
        authValue['password'].toString());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password ?',
          style: TextStyle(fontSize: width / 20),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(width / 20),
        margin: EdgeInsets.only(top: width / 20),
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: gKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: width / 25),
                    ),
                    validator: (value) {
                      if (value == '') {
                        return "Please enter your email id";
                      }
                    },
                    onSaved: (value) {
                      authValue['email'] = value.toString().trim();
                    },
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: width / 25),
                    ),
                    validator: (value) {
                      if (value.toString().trim() == '') {
                        return "Please enter a password";
                      }

                      if (value.toString().trim().length < 6) {
                        return 'Minimum 6 characters required';
                      }
                    },
                    onSaved: (value) {
                      authValue['password'] = value.toString().trim();
                    },
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(fontSize: width / 25),
                    ),
                    validator: (value) {
                      if (value.toString().trim() !=
                          password.text.toString().trim()) {
                        return "Password doesn't match";
                      }
                    },
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  InkWell(
                    onTap: () {
                      return _onSaved();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Center(
                          child: _isLoading
                              ? SizedBox(
                                  child: CircularProgressIndicator(),
                                  height: width / 10,
                                  width: width / 10,
                                )
                              : Text(
                                  "Update Password",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width / 25,
                                  ),
                                )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
