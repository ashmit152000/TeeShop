import 'package:flutter/material.dart';

class YourProfileScreen extends StatefulWidget {
  static const routeName = '/your-profile';

  @override
  _YourProfileScreenState createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();

  void updateAccount() {
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
                      controller: phonenumberController,
                      enabled: false,
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        enabled: true,
                                        decoration: InputDecoration(
                                            hintText: 'Full Name',
                                            labelText: 'Full Name'),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            emailController.text = value;
                                          } else {
                                            emailController.text = email;
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        enabled: true,
                                        decoration: InputDecoration(
                                            hintText: 'Address',
                                            labelText: 'Address'),
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
    var userData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(userData);
    fullNameController.text = userData['full_name'] != null
        ? userData['full_name'].toString()
        : 'Ashmit Pathak';
    emailController.text =
        userData['email'] != null ? userData['email'].toString() : '';

    phonenumberController.text = '+919588955499';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
        ),
        body: SingleChildScrollView(
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
                              hintText: 'Fullname', labelText: 'Full Name'),
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
                          updateAccount();
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
