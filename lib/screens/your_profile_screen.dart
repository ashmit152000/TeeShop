import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teeshop/providers/auth.dart';
import 'package:teeshop/widgets/app_drawer.dart';

class YourProfileScreen extends StatefulWidget {
  static const routeName = '/your-profile';

  @override
  _YourProfileScreenState createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController fullNamePopController = TextEditingController();
  TextEditingController addressPopController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailPopController = TextEditingController();
  TextEditingController phoneNumberPopController = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController pincode = TextEditingController();
  var width;
  var height;
  var verify;
  var _isLoading = false;
  var userData;
  var fullNumber;
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<FormState> emailUni = GlobalKey();
  GlobalKey<FormState> phoneUni = GlobalKey();
  GlobalKey<FormState> info = GlobalKey();

  void getDataWorking() async {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Auth>(context, listen: false).getUser(context).then((value) {
      setState(() {
        userData = value['user'];
        emailController.text =
            value['user']['email'] == null ? '' : value['user']['email'];
        fullNameController.text = value['user']['full_name'] == null
            ? ''
            : value['user']['full_name'];
        fullNamePopController.text = value['user']['full_name'] == null
            ? ''
            : value['user']['full_name'];
        addressPopController.text =
            value['user']['address'] == null ? '' : value['user']['address'];
        addressController.text =
            value['user']['address'] == null ? '' : value['user']['address'];

        phonenumberController.text = value['user']['phone_number'] == null
            ? ''
            : value['user']['phone_number'].toString();
        _isLoading = false;
      });
    });
  }

  void editEmail(String email) {
    var isValid = emailUni.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (email != '') {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Auth>(context, listen: false)
          .editUser(
        context,
        height,
        width,
        id: userData['id'],
        email: emailPopController.text,
      )
          .then((value) {
        emailController.text = value['user']['email'];
        getDataWorking();
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void editPhone(String phoneNumber) {
    var isPassValid = phoneUni.currentState!.validate();
    if (!isPassValid) {
      return;
    }
    if (phoneNumber != '' && phoneNumber.length == 10) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Auth>(context, listen: false)
          .editUser(context, height, width,
              id: userData['id'],
              phoneNumber:
                  "+91" + phoneNumberPopController.text.toString().trim())
          .then((value) {
        phonenumberController.text = value['user']['phone_number'];
        getDataWorking();
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void editData(
      {String? fullName, String? address, String? phoneNumber}) async {
    var isDetailValid = info.currentState!.validate();

    if (!isDetailValid) {
      return;
    }

    if (fullName != null && address != null) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Auth>(context, listen: false)
          .editUser(context, height, width,
              id: userData['id'],
              fullName: fullNamePopController.text,
              address: addressPopController.text + "" + pincode.text)
          .then((value) {
        addressController.text = value['user']['address'];

        fullNameController.text = value['user']['full_name'];
        getDataWorking();
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataWorking();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void showMe(BuildContext context, String type) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Verify Email and Password',
                    style: TextStyle(fontSize: width / 20),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  if (type == 'email')
                    Container(
                      child: TextFormField(
                        controller: emailController,
                        enabled: false,
                        style: TextStyle(fontSize: width / 25),
                        decoration: InputDecoration(
                            hintText: 'Present Email',
                            labelText: 'Present Email'),
                      ),
                    ),
                  if (type == 'phone')
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phonenumberController,
                        style: TextStyle(fontSize: width / 25),
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: 'Present Phone number',
                            labelText: 'Present Phone number'),
                      ),
                    ),
                  SizedBox(
                    height: height / 30,
                  ),
                  if (type == 'email' && userData['confirmed'] == false)
                    ElevatedButton(
                      onPressed: () async {
                        await Provider.of<Auth>(context, listen: false)
                            .sendVerification();
                        Fluttertoast.showToast(
                            msg:
                                'Verrification sent on your registered email address',
                            backgroundColor: Colors.green,
                            fontSize: width / 25);
                      },
                      child: Text('Send Verification'),
                      style: ElevatedButton.styleFrom(color: primary: Colors.green),
                    ),

                  if (type == 'phone' &&
                      userData['phone_verified'] == false &&
                      userData['phone_number'] != null)
                    ElevatedButton(
                      onPressed: () async {
                        otp.text = '';
                        setState(() {
                          _isLoading = true;
                        });
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: phonenumberController.text,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            setState(() {
                              _isLoading = false;
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Enter OTP',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: width / 25,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            TextFormField(
                                              controller: otp,
                                              enabled: true,
                                              style: TextStyle(
                                                  fontSize: width / 25),
                                              decoration: InputDecoration(
                                                  hintText: 'OTP',
                                                  labelText: 'OTP'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                FirebaseAuth auth =
                                                    FirebaseAuth.instance;
                                                verify = PhoneAuthProvider
                                                    .credential(
                                                        verificationId:
                                                            verificationId,
                                                        smsCode:
                                                            otp.text.trim());
                                                try {
                                                  auth
                                                      .signInWithCredential(
                                                          verify)
                                                      .then((value) {
                                                    print(value);
                                                    Provider.of<Auth>(context,
                                                            listen: false)
                                                        .confirmPhone(
                                                            userData['id'])
                                                        .then((value) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Phone number verified',
                                                          fontSize: width / 25,
                                                          backgroundColor:
                                                              Colors.green);
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    }).onError((error,
                                                            stackTrace) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Wrong otp entered',
                                                          fontSize: width / 25,
                                                          backgroundColor:
                                                              Colors.red);
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    });
                                                  });
                                                } catch (err) {
                                                  Fluttertoast.showToast(
                                                      msg: 'Wrong otp entered',
                                                      fontSize: width / 25,
                                                      backgroundColor:
                                                          Colors.red);
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Verify',
                                                style: TextStyle(
                                                  fontSize: width / 25,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      },
                      child: Text(
                        'Send Verification',
                        style: TextStyle(fontSize: width / 30),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                  // Start here

                  if (type == 'email')
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Update Email',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: width / 20),
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Form(
                                          key: emailUni,
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style:
                                                TextStyle(fontSize: width / 25),
                                            enabled: true,
                                            controller: emailPopController,
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                              labelText: 'Email',
                                              labelStyle: TextStyle(
                                                  fontSize: width / 25),
                                            ),
                                            validator: (value) {
                                              if (value == '') {
                                                return 'Enter an email address';
                                              }

                                              if (!value
                                                  .toString()
                                                  .contains('@')) {
                                                return ('Enter a valid email address');
                                              }
                                            },
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (emailUni.currentState!
                                                .validate()) {
                                              Navigator.of(context).pop();
                                              editEmail(
                                                  emailPopController.text);
                                            }
                                          },
                                          child: Text(
                                            'Update',
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        'Edit Email',
                        style: TextStyle(fontSize: width / 30),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.amber),
                    ),
                  // Update email ends here
                  if (type == 'phone')
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Update Phone Number',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: width / 20),
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Form(
                                          key: phoneUni,
                                          child: TextFormField(
                                            style:
                                                TextStyle(fontSize: width / 25),
                                            enabled: true,
                                            controller:
                                                phoneNumberPopController,
                                            decoration: InputDecoration(
                                              hintText: 'Phone number',
                                              labelText: 'Phone number',
                                              labelStyle: TextStyle(
                                                  fontSize: width / 25),
                                            ),
                                            validator: (value) {
                                              if (value == '') {
                                                return 'Enter a phone number';
                                              }

                                              if (value.toString().length !=
                                                  10) {
                                                return 'Enter a valid phone number';
                                              }
                                              if (value
                                                  .toString()
                                                  .contains('+91')) {
                                                return 'Remove the country code.';
                                              }
                                            },
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (phoneUni.currentState!
                                                .validate()) {
                                              Navigator.of(context).pop();
                                              editPhone(phoneNumberPopController
                                                  .text);
                                            }
                                          },
                                          child: Text(
                                            'Update',
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        'Edit Phone Number',
                        style: TextStyle(fontSize: width / 30),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.amber),
                    ),

                  SizedBox(
                    height: height / 50,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Do you want to exit ?',
              style: TextStyle(color: Colors.deepPurple),
            ),
            content: new Text('We were enjoying your time with us.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          drawer: AppDrawer(userData: userData),
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            title: Text(
              'My Profile',
              style: TextStyle(fontSize: width / 25),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF5f0a87), Color(0xFF703ED1)],
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: width / 30),
                child: TextButton(
                  onPressed: () {
                    getDataWorking();
                  },
                  child: Text(
                    'Refresh',
                    style: TextStyle(fontSize: width / 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          body: _isLoading
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: width / 10,
                    width: width / 10,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: width / 12,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Flexible(
                                flex: 10,
                                child: Row(children: [
                                  Text(
                                    'Fullname: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width / 25),
                                  ),
                                  SizedBox(
                                    width: width / 40,
                                  ),
                                  Expanded(
                                    child: userData['full_name'] != null
                                        ? Text(
                                            userData['full_name'],
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          )
                                        : Text(
                                            '',
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width / 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Flexible(
                                flex: 10,
                                child: Row(children: [
                                  Text(
                                    'Address: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width / 25),
                                  ),
                                  SizedBox(
                                    width: width / 40,
                                  ),
                                  Expanded(
                                    child: userData['address'] != null
                                        ? Text(
                                            userData['address'],
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          )
                                        : Text(
                                            '',
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width / 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            // showBottomSheetMethod();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Update Details',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Form(
                                              key: info,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        fullNamePopController,
                                                    enabled: true,
                                                    style: TextStyle(
                                                        fontSize: width / 25),
                                                    decoration: InputDecoration(
                                                        hintText: 'Full Name',
                                                        labelText: 'Full Name'),
                                                    validator: (value) {
                                                      if (value == '') {
                                                        return 'Enter your full name';
                                                      }
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        addressPopController,
                                                    maxLines: 5,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    enabled: true,
                                                    style: TextStyle(
                                                        fontSize: width / 25),
                                                    decoration: InputDecoration(
                                                        hintText: 'Address',
                                                        labelText: 'Address'),
                                                    validator: (value) {
                                                      if (value == '') {
                                                        return 'Enter your address';
                                                      }
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller: pincode,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    enabled: true,
                                                    style: TextStyle(
                                                        fontSize: width / 25),
                                                    decoration: InputDecoration(
                                                        hintText: 'Pincode',
                                                        labelText: 'Pincode'),
                                                    validator: (value) {
                                                      if (value == '') {
                                                        return 'Enter your pincode';
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (info.currentState!
                                                    .validate()) {
                                                  Navigator.of(context).pop();

                                                  editData(
                                                      fullName:
                                                          fullNamePopController
                                                              .text,
                                                      address:
                                                          addressPopController
                                                              .text);
                                                }
                                              },
                                              child: Text(
                                                'Update',
                                                style: TextStyle(
                                                    fontSize: width / 30),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.deepPurple,
                              child: Center(
                                child: Text(
                                  'Change Fullname and address',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width / 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width / 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Flexible(
                                flex: 10,
                                child: Row(children: [
                                  Text(
                                    'Email: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width / 25),
                                  ),
                                  SizedBox(
                                    width: width / 40,
                                  ),
                                  Expanded(
                                    child: userData['email'] != null
                                        ? Text(
                                            userData['email'],
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          )
                                        : Text(
                                            '',
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                  )
                                ]),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: width / 15,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: userData['confirmed'] == true
                                  ? Icon(
                                      Icons.verified,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.dangerous,
                                      color: Colors.red,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width / 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            // showBottomSheetMethod();
                            showMe(context, 'email');
                          },
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.deepPurple,
                              child: Center(
                                child: Text(
                                  'Click to update/verify Email',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width / 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width / 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Flexible(
                                flex: 10,
                                child: Row(children: [
                                  Text(
                                    'Phone number: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width / 25),
                                  ),
                                  SizedBox(
                                    width: width / 40,
                                  ),
                                  Expanded(
                                    child: userData['phone_number'] != null
                                        ? Text(
                                            userData['phone_number'],
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          )
                                        : Text(
                                            '',
                                            style:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                  )
                                ]),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: userData['phone_verified'] == true
                                  ? Icon(
                                      Icons.verified,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.dangerous,
                                      color: Colors.red,
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            // showBottomSheetMethod();
                            showMe(context, 'phone');
                          },
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.deepPurple,
                              child: Center(
                                child: Text(
                                  'Click to change/verify Phone number',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width / 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
