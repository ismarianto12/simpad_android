import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _konfirmasiPassword = TextEditingController();
  final _passwordController = TextEditingController();

  final _globalKey = GlobalKey<FormState>();

  void _submitForm() async {
    if (_globalKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Icon(Icons.verified_user_sharp, size: 40.0),
            SizedBox(height: 10),
            Text(
              "Profil Login ",
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _globalKey,
                child:
                    // TextEditingController(text: )
                    Column(
                  children: [
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
                                      20.0), // Adjust the radius as needed
                                ),
                              ),
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors
                                        .red; // Color when the button is pressed.
                                  }
                                  return Color.fromARGB(255, 20, 215,
                                      88); // Default color for the button.
                                },
                              ),
                            ),
                            onPressed: () => _submitForm(),
                            child: Text('Simpan',
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
                                        20.0), // Adjust the radius as needed
                                  ),
                                ),
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
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
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
