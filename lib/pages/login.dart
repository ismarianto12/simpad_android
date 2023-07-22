import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpad_flutter/env.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isDialogShowing = false;

  bool _validateInputs() {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var url = Uri.parse('${APP_API}/v1/api/apilogin');
      var response = await http.post(url, body: {
        'username': _usernameController.text,
        'password': _passwordController.text,
      });
      print("Status code ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['token'];
        if (!_isDialogShowing) {
          setState(() {
            _isDialogShowing = true;
          });

          final snackBar = SnackBar(
            content: Text('Login berhasil'),
            duration: Duration(
                seconds:
                    3), // Optional: Control how long the Snackbar will be displayed
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Do something when the user clicks the action button (e.g., undo)
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard_panel', (route) => false);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Gagal'),
              content: const Text('Silahkan Check username dan password.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/dashboard_panel', (route) => false);
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0),
                  ),
                  color: Color.fromARGB(255, 62, 154, 229),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Image.asset(
                      "assets/images/login.webp",
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'SIMPATDA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const Text(
                      'SISTEM PENGEOLAAN DAN PELAPORAN PAJAK DAERAH',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 22),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: const Color.fromARGB(
                                    255,
                                    140,
                                    139,
                                    139,
                                  ),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.verified_user_sharp,
                                color: const Color.fromARGB(
                                  255,
                                  140,
                                  139,
                                  139,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    140,
                                    139,
                                    139,
                                  ),
                                ),
                              ),
                              fillColor: const Color.fromARGB(
                                255,
                                140,
                                139,
                                139,
                              ),
                              hintText: 'Username / Npwpd',
                              hintStyle: TextStyle(
                                color: const Color.fromARGB(
                                  255,
                                  140,
                                  139,
                                  139,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: const Color.fromARGB(
                                    255,
                                    140,
                                    139,
                                    139,
                                  ),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.access_alarms,
                                color: const Color.fromARGB(
                                  255,
                                  140,
                                  139,
                                  139,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    140,
                                    139,
                                    139,
                                  ),
                                ),
                              ),
                              fillColor: const Color.fromARGB(
                                255,
                                140,
                                139,
                                139,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: const Color.fromARGB(
                                  255,
                                  140,
                                  139,
                                  139,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                height: 45,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Adjust the radius as needed
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                      (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors
                                              .red; // Color when the button is pressed.
                                        }
                                        return Color.fromARGB(255, 20, 215,
                                            88); // Default color for the button.
                                      },
                                    ),
                                  ),
                                  onPressed: () => _submitForm(),
                                  child: Text('Login',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.99,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0), // Adjust the radius as needed
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                        (states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Colors
                                                .red; // Color when the button is pressed.
                                          }
                                          return Colors
                                              .blue; // Default color for the button.
                                        },
                                      ),
                                    ),
                                    onPressed: () => null,
                                    child: Text('Batal',
                                        style: TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),
                          SizedBox(height: 126),
                          InkWell(
                            onTap: () {
                              // TODO: Implement Forgot Password functionality
                            },
                            child: Text(
                              'Forget Password ?',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          // SizedBox(height: 16),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
