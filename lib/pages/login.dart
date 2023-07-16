// import 'dart:math';

// import 'package:penitipan/components/Navigate.dart';
// import 'package:penitipan/env.dart';
// import 'package:penitipan/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:simpad_flutter/components/navigate.dart';
// import 'forgot.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _validateInputs() {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _submitForm() async {
    // Route route = MaterialPageRoute(builder: (context) => null);
    // Navigator.push(context, route);

    // if (_validateInputs()) {
    //   List<String> printdata = [
    //     _usernameController.text,
    //     _passwordController.text,
    //   ];
    //   var url = Uri.parse(API_URL + '/login');
    //   var response = await http.post(url, body: {
    //     'username': _usernameController.text,
    //     'password': _passwordController.text,
    //   });
    //   print('${response.body}');
    //   if (response.statusCode == 200) {
    //     // SharedPreferences prefs = await SharedPreferences.getInstance();
    //     // prefs.setString('storage', response.body);
    //     // Route route = MaterialPageRoute(builder: (context) => const Navigate());
    //     // Navigator.push(context, route);
    //   } else {
    //     print('${response.body}');
    //   }
    // } else {
    //   print('Form validation failed.');
    // }
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
            // AssetImage("assets/images/login.jpeg"),

            Container(
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35.0),
                  bottomRight: Radius.circular(35.0),
                ),
                color: Color.fromARGB(255, 62, 154, 229),
              ),
              child: Column(children: [
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
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                const Text(
                  'SISTEM PENGEOLAAN DAN PELAPORAN PAJAK DAERAH',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(height: 22),
              ]),
            ),

            SizedBox(height: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                        255, 140, 139, 139)) //<-- SEE HERE
                                ),
                            prefixIcon: Icon(
                              Icons.verified_user_sharp,
                              color: const Color.fromARGB(255, 140, 139, 139),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 140, 139, 139)),
                            ),
                            fillColor: const Color.fromARGB(255, 140, 139, 139),
                            hintText: 'Username /Npwpd',
                            hintStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 140, 139, 139)),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
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
                                        255, 140, 139, 139)) //<-- SEE HERE
                                ),
                            prefixIcon: Icon(
                              Icons.access_alarms,
                              color: const Color.fromARGB(255, 140, 139, 139),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 140, 139, 139)),
                            ),
                            fillColor: const Color.fromARGB(255, 140, 139, 139),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 140, 139, 139)),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
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
                              width: 400,
                              // margin: EdgeInsets.all(30),
                              child: MaterialButton(
                                // minWidth: 100,
                                color: Color.fromARGB(
                                    255, 139, 187, 17), // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) => const Navigate());
                                  Navigator.push(context, route);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 400,
                              child: MaterialButton(
                                // minWidth: 100,
                                color: Color.fromARGB(
                                    255, 230, 132, 5), // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) => const Navigate());
                                  Navigator.push(context, route);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Daftar',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 126),
                        InkWell(
                          onTap: () {
                            // Route route = MaterialPageRoute(
                            //     builder: (context) => null);
                            // Navigator.push(context, route);
                            // null
                          },
                          child: Text(
                            'Forget Passowrd ?',
                            style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _usernameController.text;
    _passwordController.text;
    super.dispose();
  }
}
