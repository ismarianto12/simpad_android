import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensi_app/components/SliderDepan.dart';
import 'package:presensi_app/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presensi_app/utils/middleware.dart';

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

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please wait.',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  width: 20,
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    if (_isDialogShowing) {
      Navigator.of(context).pop();
      setState(() {
        _isDialogShowing = false;
      });
    }
  }

  void _cancel() {
    _usernameController.text = "";
    _passwordController.text = "";
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Middleware.checkCon(context);

      String username = _usernameController.text;
      // setState(() {
      //   _isLoading = true;
      // });
      // _showLoadingDialog();
      // var url = Uri.parse('${APP_API}/v1/api/apilogin');
      // var response = await http.post(url, body: {
      //   'username': _usernameController.text,
      //   'password': _passwordController.text,
      // });

      if (username == 'admin') {
        // var jsonResponse = json.decode(response.body);

        var token = "dsada"; //jsonResponse['token'];
        var userid = "12"; // jsonResponse['userid'].toString();
        var pajakname = "HTEL"; // jsonResponse['pajakname'].toString();

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("username", _usernameController.text);
        pref.setString("userid", userid);
        pref.setString("pajakname", pajakname.toString());

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
        Navigator.of(context).pop();
        setState(() {
          _isDialogShowing = false;
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
                    Navigator.of(context).pop();
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/dashboard_panel', (route) => false);
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
                width: MediaQuery.sizeOf(context).width * 100,
                height: MediaQuery.sizeOf(context).height * 0.30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0),
                  ),
                  color: Color.fromARGB(255, 12, 125, 218),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 18.0),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(15.0),
                          width: MediaQuery.sizeOf(context).width * 0.80,
                          height: MediaQuery.sizeOf(context).width * 0.40,
                          child: Expanded(flex: 0, child: SliderDepan())),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextFormField(
                            controller: _usernameController,
                            // keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 8.0),
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
                              border: OutlineInputBorder(),
                              fillColor: const Color.fromARGB(
                                255,
                                140,
                                139,
                                139,
                              ),
                              hintText: 'Username',
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 8.0),
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
                                height: 35,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the radius as needed
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
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.99,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Adjust the radius as needed
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
                                          return Color.fromARGB(255, 194, 124,
                                              43); // Default color for the button.
                                        },
                                      ),
                                    ),
                                    onPressed: () => _cancel(),
                                    child: Text('Batal',
                                        style: TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),
                          SizedBox(height: 100),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/daftarwp', (route) => false);
                            },
                            child: Text(
                              'Cek Status Presensi',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/lupapass', (route) => false);
                            },
                            child: Text(
                              'Lupa Password ? ',
                              style: TextStyle(
                                // color : ,
                                fontSize: 14,
                                color: Color.fromARGB(255, 10, 157, 215),
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
