import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpad_flutter/utils/middleware.dart';
import 'package:simpad_flutter/utils/service.dart';
import 'package:http/http.dart' as http;

import 'package:simpad_flutter/env.dart';
import 'dart:convert';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _konfirmasiPassword = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _npwpdController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  void _submitForm() async {
    if (_globalKey.currentState!.validate()) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String getlisusername = pref.getString('username').toString();
      var url = Uri.parse(APP_API + "/profile");
      final response = await http.post(url, body: {
        'userid': getlisusername
      }, headers: {
        "Content-Type": "application/json",
      });
      // print("response : ${response}");
      if (response.statusCode == 200) {
      } else {
        // Material
        final snackBar = SnackBar(
          content: Text('Gagal'),
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
      }
    }
  }

  Future<List<dynamic>> getProfile() async {
    final List<dynamic> data = await Service.profile();
    return data;
  }

  String getusername = '';
  String getpajakname = '';
  Future<String?> _username() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String getlisusername = pref.getString('username').toString();
    String getpajakname = pref.getString('pajakname').toString();

    setState(() {
      getusername = getlisusername;
      getpajakname = getpajakname;
    });
  }

  @override
  void initState() {
    super.initState();
    var data = getProfile();
    _username();
    _npwpdController.text = getusername.toString();
  }

  _cancel() {
    _konfirmasiPassword.text = '';
    _passwordController.text = '';
    _emailController.text = '';
    _npwpdController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // width: double.infinity,
                    // height: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/premium-vector/smartphone-ui-ux-design-concept-application_73903-155.jpg"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.16),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 100,
                      height: MediaQuery.of(context).size.height - 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Edit Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: _globalKey,
                                child:
                                    // TextEditingController(text: )
                                    Column(
                                  children: [
                                    TextFormField(
                                      controller: _npwpdController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
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
                                          Icons.supervised_user_circle_outlined,
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
                                        hintText: 'NPWPD',
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
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
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
                                          Icons.type_specimen_sharp,
                                          color: const Color.fromARGB(
                                            255,
                                            140,
                                            139,
                                            139,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
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
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
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
                                        hintText: 'Ulang Password',
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
                                      height: 40,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.99,
                                          height: 35,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0), // Adjust the radius as needed
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith(
                                                (states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return Colors
                                                        .red; // Color when the button is pressed.
                                                  }
                                                  return Color.fromARGB(
                                                      255,
                                                      20,
                                                      215,
                                                      88); // Default color for the button.
                                                },
                                              ),
                                            ),
                                            onPressed: () => _submitForm(),
                                            child: Text('Simpan',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 35,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.99,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20),
                                                    ), // Adjust the radius as needed
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith(
                                                  (states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors
                                                          .red; // Color when the button is pressed.
                                                    }
                                                    return Colors
                                                        .blue; // Default color for the button.
                                                  },
                                                ),
                                              ),
                                              onPressed: () => _cancel(),
                                              child: Text('Batal',
                                                  style: TextStyle(
                                                      color: Colors.white))),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
