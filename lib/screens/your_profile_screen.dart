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
  var width;
  var height;
  var verify;
  var _isLoading = false;
  var userData;
  var fullNumber;
  FirebaseAuth auth = FirebaseAuth.instance;

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

  void editData(
      {String? fullName,
      String? address,
      String? email,
      String? phoneNumber}) async {
    setState(() {
      _isLoading = true;
    });
    if (email != null) {
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
        setState(() {
          _isLoading = false;
        });
      });
    }

    if (fullName != null && address != null) {
      Provider.of<Auth>(context, listen: false)
          .editUser(context, height, width,
              id: userData['id'],
              fullName: fullNamePopController.text,
              address: addressPopController.text)
          .then((value) {
        addressController.text = value['user']['address'];

        fullNameController.text = value['user']['full_name'];
        setState(() {
          _isLoading = false;
        });
      });
    }

    if (phoneNumber != null) {
      Provider.of<Auth>(context, listen: false)
          .editUser(context, height, width,
              id: userData['id'], phoneNumber: phonenumberController.text)
          .then((value) {
        phonenumberController.text = value['user']['phone_number'];
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    getDataWorking();

    super.didChangeDependencies();
  }

  void updateAccount(BuildContext context) {
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
                    'Update Details',
                    style: TextStyle(fontSize: width / 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFormField(
                      controller: fullNameController,
                      enabled: false,
                      style: TextStyle(fontSize: width / 25),
                      decoration: InputDecoration(
                          hintText: 'Present Full Name',
                          labelText: 'Present Full Name'),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: addressController,
                      enabled: false,
                      maxLines: 5,
                      style: TextStyle(fontSize: width / 25),
                      decoration: InputDecoration(
                          hintText: 'Present Address',
                          labelText: 'Present Address'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Update Details',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              content: SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextFormField(
                                        controller: fullNamePopController,
                                        enabled: true,
                                        style: TextStyle(fontSize: width / 25),
                                        decoration: InputDecoration(
                                            hintText: 'Full Name',
                                            labelText: 'Full Name'),
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            value = userData['full_name'];
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        controller: addressPopController,
                                        maxLines: 5,
                                        keyboardType: TextInputType.multiline,
                                        enabled: true,
                                        style: TextStyle(fontSize: width / 25),
                                        decoration: InputDecoration(
                                            hintText: 'Address',
                                            labelText: 'Address'),
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            value = userData['address'];
                                          }
                                        },
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();

                                          editData(
                                              fullName:
                                                  fullNamePopController.text,
                                              address:
                                                  addressPopController.text);
                                        },
                                        child: Text(
                                          'Update',
                                          style:
                                              TextStyle(fontSize: width / 30),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                    child: Text(
                      'Edit Details',
                      style: TextStyle(fontSize: width / 30),
                    ),
                  ),
                  SizedBox(height: height / 50),
                ],
              ),
            ),
          );
        });
  }

  void showMe(BuildContext context, String type) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          var phoneNumber = phonenumberController.text;
          var email = emailController.text;
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
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),

                  if (type == 'phone' && userData['phone_verified'] == false)
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
                                        TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style:
                                              TextStyle(fontSize: width / 25),
                                          enabled: true,
                                          controller: emailPopController,
                                          decoration: InputDecoration(
                                            hintText: 'Email',
                                            labelText: 'Email',
                                            labelStyle:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              emailController.text = value;
                                            } else {
                                              emailController.text = email;
                                            }
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            editData(
                                                email: emailPopController.text);
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
                                        TextFormField(
                                          style:
                                              TextStyle(fontSize: width / 25),
                                          enabled: true,
                                          controller: phoneNumberPopController,
                                          decoration: InputDecoration(
                                            hintText: 'Phone number',
                                            labelText: 'Phone number',
                                            labelStyle:
                                                TextStyle(fontSize: width / 25),
                                          ),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              phonenumberController.text =
                                                  "+91" + value;
                                            } else {
                                              phonenumberController.text =
                                                  phoneNumber;
                                            }
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            editData(
                                                phoneNumber:
                                                    phoneNumberPopController
                                                        .text);
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

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          actions: [
            IconButton(
                onPressed: () {
                  getDataWorking();
                },
                icon: Icon(Icons.replay_outlined))
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: TextFormField(
                                enabled: false,
                                controller: fullNameController,
                                style: TextStyle(fontSize: width / 25),
                                decoration: InputDecoration(
                                    hintText: 'Fullname',
                                    labelText: 'Full Name'),
                              ),
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
                              child: TextFormField(
                                maxLines: 5,
                                enabled: false,
                                style: TextStyle(fontSize: width / 25),
                                controller: addressController,
                                decoration: InputDecoration(
                                    hintText: 'Address', labelText: 'Address'),
                              ),
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
                              child: TextFormField(
                                enabled: false,
                                controller: emailController,
                                style: TextStyle(fontSize: width / 25),
                                decoration: InputDecoration(
                                    hintText: 'Email', labelText: 'Email'),
                              ),
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Flexible(
                              flex: 10,
                              child: TextFormField(
                                enabled: false,
                                keyboardType: TextInputType.number,
                                controller: phonenumberController,
                                style: TextStyle(fontSize: width / 25),
                                decoration: InputDecoration(
                                    hintText: 'Phone number',
                                    labelText: 'Phone number'),
                              ),
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
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // showBottomSheetMethod();
                                updateAccount(context);
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.purple,
                                  child: Text(
                                    'Update Account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 45,
                            ),
                            GestureDetector(
                              onTap: () {
                                // showBottomSheetMethod();
                                showMe(context, 'email');
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.purple,
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
                            SizedBox(
                              height: height / 45,
                            ),
                            GestureDetector(
                              onTap: () {
                                // showBottomSheetMethod();
                                showMe(context, 'phone');
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.purple,
                                  child: Text(
                                    'Click to update/verify Phone number',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
