import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/login.dart';
import 'dart:convert';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController UserNameController = TextEditingController();
  final TextEditingController UserEmailController = TextEditingController();
  final TextEditingController UserpassController = TextEditingController();
  final TextEditingController UserrePassController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isRepeatPasswordVisible = false;

  Future<void> _forgotpass(BuildContext context, String username, String useremail, String userpass, String userconfirmpass) async {
    try {
      final String apiUrl = 'https://loginapi.somee.com/API/LOGIN/ResetPassword';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'useremail': useremail, 'userpassword': userpass, 'userconfirmpassword': userconfirmpass}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData.isNotEmpty) {
          final Map<String, dynamic> data = responseData.first;

          if (data.containsKey('Type') && data.containsKey('Message')) {
            if(data['Type'].toString() == 'VALIDATION'){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Validation Error'),
                    content: Text(data['Message'].toString()),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
            else{
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Password Reset Successful'),
                    content: Text(data['Message'].toString()),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
            return;
          }
        }
      }
    } catch (e) {
      print('Error making the request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 50.0, top: 0.0),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350), // Adjust max width as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: UserNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: UserEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: UserpassController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: UserrePassController,
                    obscureText: !_isRepeatPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Repeat your password',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_isRepeatPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isRepeatPasswordVisible = !_isRepeatPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        // Mandatory field validation
                        if (UserNameController.text.toString().trim() == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Username required.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        if (UserEmailController.text.toString().trim() == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email Id required.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        if (UserpassController.text.toString().trim() == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password required.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        if (UserrePassController.text.toString().trim() == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Repeat your password required.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        // Password matching validation
                        if (UserpassController.text != UserrePassController.text) {
                          // Display an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password does not match'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        // Pass the context to the reset function
                        _forgotpass(
                          context,
                          UserNameController.text,
                          UserEmailController.text,
                          UserpassController.text,
                          UserrePassController.text,
                        );
                      },
                      color: Color(0xFF667eea),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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