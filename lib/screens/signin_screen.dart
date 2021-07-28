import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/data/http_exception.dart';
import 'package:teeshop/providers/auth.dart';

enum AuthMode { Signup, Signin }

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  var authMode = AuthMode.Signin;
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  late Animation<Offset> _slideTransition;
  bool _isLoadingCheck = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  Map<String, String> authData = {"email": "", "password": ""};
  late String emailId;
  late String passwordId;
  late String cPasswordId;
  late GlobalKey<FormState> gKey = GlobalKey();
  var width;
  var height;
  bool _isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('An error occured'),
            content: Text(message),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    Provider.of<Auth>(context, listen: false).token(context).then((value) {
      setState(() {
        _isLoadingCheck = false;
      });
    });
    super.initState();
    animation =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
    _slideTransition = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(animation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void auth() async {
    bool _valid = gKey.currentState!.validate();
    if (!_valid) {
      return;
    }
    gKey.currentState!.save();
    print(authData['email'].toString());
    print(authData['password'].toString());
    setState(() {
      _isLoading = true;
    });
    if (authMode == AuthMode.Signin) {
      try {
        await Provider.of<Auth>(context, listen: false).login(context,
            email: authData['email'].toString(),
            password: authData["password"].toString());
      } catch (error) {
        print(error);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Auth>(context, listen: false).signUp(
            authData['email'].toString(),
            authData["password"].toString(),
            context);
      } on HttpException catch (error) {
        _showErrorDialog(error.toString());
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animation.dispose();
  }

  void toggleAuth() {
    if (authMode == AuthMode.Signin) {
      setState(() {
        email.clear();
        password.clear();
        authMode = AuthMode.Signup;
      });
      animation.forward();
    } else {
      setState(() {
        email.clear();
        password.clear();
        authMode = AuthMode.Signin;
      });
      animation.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff21254A),
        resizeToAvoidBottomInset: false,
        body: _isLoadingCheck
            ? Center(
                child: AlertDialog(
                  title: Text(
                    'Loading...',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: height / 4,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/images/1.png'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'WELCOME TO',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 15),
                                    ),
                                    Text(
                                      '🙏 TEESHOP 🙏',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 15),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height / 20,
                              ),
                              Form(
                                key: gKey,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: TextFormField(
                                              controller: email,
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: TextStyle(
                                                  fontSize: width / 25,
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Email',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              validator: (value) {
                                                if (value.toString() == '') {
                                                  return "Please fill in your email id";
                                                }
                                                if (!value
                                                    .toString()
                                                    .contains('@')) {
                                                  return 'Please enter a valid email id';
                                                }
                                              },
                                              onSaved: (value) {
                                                authData['email'] =
                                                    value.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height / 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: TextFormField(
                                              controller: password,
                                              textInputAction:
                                                  TextInputAction.next,
                                              obscureText: true,
                                              obscuringCharacter: '*',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width / 25,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Password',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              validator: (value) {
                                                if (value.toString() == '') {
                                                  return "Please fill in a password";
                                                }
                                                if (value.toString().length <
                                                    6) {
                                                  return "Password should be 6 characters long";
                                                }
                                              },
                                              onSaved: (value) {
                                                authData['password'] =
                                                    value.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height / 20,
                                    ),
                                    authMode == AuthMode.Signup
                                        ? SlideTransition(
                                            position: _slideTransition,
                                            child: FadeTransition(
                                              opacity: _fadeInFadeOut,
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: TextFormField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        obscureText: true,
                                                        obscuringCharacter: '*',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: width / 25,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Confirm Password',
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        validator: (value) {
                                                          if (value !=
                                                              password.text) {
                                                            return "Password doesn't match";
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: height / 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print(authMode);
                                        return toggleAuth();
                                      },
                                      child: Text(
                                        authMode == AuthMode.Signin
                                            ? 'Don\'t have an account ? Sign up'
                                            : 'Already have an account ? Sign in',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 25,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        return auth();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF5f0a87),
                                            Color(0xFF703ED1)
                                          ]),
                                        ),
                                        child: Center(
                                          child: _isLoading != true
                                              ? Text(
                                                  authMode == AuthMode.Signin
                                                      ? 'SIGN IN'
                                                      : 'SIGN UP',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width / 25,
                                                  ),
                                                )
                                              : CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
