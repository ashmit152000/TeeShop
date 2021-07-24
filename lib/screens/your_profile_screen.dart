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
  var _isLoading = false;
  var userData;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Auth>(context).getUser(context).then((value) {
      setState(() {
        userData = value['user'];
        emailController.text = value['user']['email'];
        fullNameController.text = value['user']['full_name'];
        fullNamePopController.text = value['user']['full_name'];
        addressPopController.text = value['user']['address'];
        addressController.text = value['user']['address'];
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  void updateAccount(BuildContext context) {
    // addressPopController.text =
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
                    'Update Details',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFormField(
                      controller: fullNameController,
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: 'Full Name', labelText: 'Full Name'),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: addressController,
                      enabled: false,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Address', labelText: 'Address'),
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
                                            Provider.of<Auth>(context,
                                                    listen: false)
                                                .editUser(context,
                                                    id: userData['id'],
                                                    fullName:
                                                        fullNamePopController
                                                            .text,
                                                    address:
                                                        addressPopController
                                                            .text)
                                                .then((value) {
                                              addressController.text =
                                                  value['user']['address'];

                                              fullNameController.text =
                                                  value['user']['full_name'];
                                            });

                                            // emailController.text =
                                            //     response['user']['email'];
                                            // fullNameController.text =
                                            //     response['user']['full_name'];
                                          },
                                          child: Text('Update'))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Text('Update Details'),
                  ),
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
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (type == 'email')
                    Container(
                      child: TextFormField(
                        controller: emailController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: 'Email', labelText: 'Email'),
                      ),
                    ),
                  if (type == 'phone')
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phonenumberController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: 'Phone number',
                            labelText: 'Phone number'),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Send Verification'),
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
                                      color: Theme.of(context).primaryColor),
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          enabled: true,
                                          decoration: InputDecoration(
                                              hintText: 'Email',
                                              labelText: 'Email'),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              emailController.text = value;
                                            } else {
                                              emailController.text = email;
                                            }
                                          },
                                        ),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Update'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text('Update Email'),
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
                                      color: Theme.of(context).primaryColor),
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          enabled: true,
                                          decoration: InputDecoration(
                                              hintText: 'Phone number',
                                              labelText: 'Phone number'),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              phonenumberController.text =
                                                  value;
                                            } else {
                                              phonenumberController.text =
                                                  phoneNumber;
                                            }
                                          },
                                        ),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Update'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text('Update Phone Number'),
                    ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(
          userData: userData,
        ),
        appBar: AppBar(
          title: Text('My Profile'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
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
                                decoration: InputDecoration(
                                    hintText: 'Fullname',
                                    labelText: 'Full Name'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
                                controller: addressController,
                                decoration: InputDecoration(
                                    hintText: 'Address', labelText: 'Address'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
                                decoration: InputDecoration(
                                    hintText: 'Email', labelText: 'Email'),
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
                        height: 20,
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
                        height: 40,
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
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
