import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/data/http_exception.dart';
import 'package:teeshop/providers/auth.dart';
import 'package:teeshop/screens/forgot_password.dart';

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
  String terms =
      "By accessing and placing an order with Teeshop India, you confirm that you are in agreement with and bound by the terms of service contained in the Terms & Conditions outlined below. These terms apply to the entire website and any email or other type of communication between you and Teeshop India.Under no circumstances shall Teeshop India team be liable for any direct, indirect, special, incidental or consequential damages. including, but not limited to, loss of data or profit, arising out of the use, or the inability to use, the materials on this site, even if Teeshop India team or an authorized representative has been advised of the possibility of such damages. If your use of materials from this site results in the need for servicing, repair or correction of equipment or data, you assume any costs thereof.Teeshop India will not be responsible for any outcome that may occur during the course of usage of our resources. We reserve the rights to change prices and revise the resources usage policy in any moment.Teeshop India grants you a revocable, non-exclusive, non- transferable, limited license to download, install and use the app strictly in accordance with the terms of this Agreement. These Terms & Conditions are a contract between you and Teeshop India ('we,' 'our,' or 'us') grants you a revocable, non-exclusive, non- transferable, limited license to download, install and use the app strictly in accordance with the terms of this Agreement.For this Terms & ConditionsCompany:  When this policy mentions 'Company,' 'we,' 'us,' 'or,' 'our,' it refers to Teeshop India, Delhi that is responsible for your information under this Privacy Policy.Country: Where Teeshop India or the owners/founders of Teeshop India are based in this case is India.Customer: Refers to the company, organization of person that signs up to use the Teeshop India Service to manage the relationships with your consumers or service users.Device: any internet connected device such as a phone, tablet computer or any other device that can be used to visit Teeshop India and use the service.IP address: Every device connected to the internet in assigned a number known as an Internet protocol (IP) address. These numbers are usually assigned in geographic blocks. An IP address can often be used to identify the location on which a device is connecting to the Internet Personnel: refers to those individuals who are employed by Teeshop India or are under contract to perform a service on behalf of one of the partiesPersonal Data: any information that directly, indirectly or in connection with other information including a personal You: a person or entity that is registered with Teeshop India to use the Services.You agree not to, and you will not permit others to: License, sell, rent, lease, assign, distribute, transmit, host, outsource, disclose or otherwise commercially explore the service of make the platform available to any third party Modify, make derivative works of, disassemble, decrypt, reverse, compile or reverse engineer any part of the service.Remove, alter or obscure any proprietary notice (including any notice of copyright or trademark of or its affiliates, partners, suppliers or the licensors of the service.If you register to any of our morning payment plans, you agree to pay a fees or changes in your account for the Service in accordance with the fees, charges and billing arms in affect at the time that each fees of charge due and payable. Unless otherwise indicated in an order form, you must provide us with a valid credit card (Visa, MasterCard, or any other issuer accepted by us) (“Payment Providers”) as a condition to signing up for the Premium plan. Your Payment Provider agreement governs your use of the designated credit card account, and you must refer to that agreement and not these Terms to determine your rights and liabilities with respect to your Payment Provider. By providing us with your credit card number and associated payment information, you agree that we are authorized to very information immediately and subsequently invoice your account for all foes and charges due and payable to us hereunder and that no additional notice or consent is required You agree to immediately notify us of any change in your billing address or the credit card used for payment hereunder. We reserve the night at any time to change its prices and billing methods, ether immediately upon posting on our Se or by mail delivery to your organization's administrator(s). Any attorney fees court costs or other costs incurred in collection of delinquent undisputed amounts shall be the responsibility of and paid for by you. No contract will waist between you and us for the Service until we accept your order try a confirmatory e-mail, SMS/MMS message, or other appropriate means of communication. You are responsible for any third-party fees that you may incur when using the Service. Refund is available only on wrong delivered product  or damaged product";

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
    Provider.of<Auth>(context, listen: false)
        .token(context, height, width)
        .then((value) {
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
        await Provider.of<Auth>(context, listen: false).login(
            context, height, width,
            email: authData['email'].toString().trim(),
            password: authData["password"].toString().trim());
      } catch (error) {
        print(error);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Auth>(context, listen: false).signUp(
            authData['email'].toString().trim(),
            authData["password"].toString().trim(),
            context,
            height,
            width);
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
    email.dispose();
    password.dispose();
    cPassword.dispose();
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
                                                    value.toString().trim();
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
                                                    value.toString().trim();
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
                                    if (authMode == AuthMode.Signin)
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              ForgotPassword.routeName);
                                        },
                                        child: Text(
                                          "Forgot Password ? ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width / 25,
                                          ),
                                        ),
                                      ),
                                    if (authMode == AuthMode.Signup)
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  scrollable: true,
                                                  title: Text(
                                                    'Terms & Conditions',
                                                    style: TextStyle(
                                                        fontSize: width / 15,
                                                        color: Colors.purple),
                                                  ),
                                                  content: Text(
                                                    terms.toString(),
                                                    style: TextStyle(
                                                        fontSize: width / 25),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          'Terms and Conditions',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width / 25,
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      height: height / 40,
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
                                              : SizedBox(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white),
                                                  height: width / 10,
                                                  width: width / 10,
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
