import 'package:flutter/material.dart';

class StatusPresensi extends StatefulWidget {
  const StatusPresensi({super.key});

  @override
  State<StatusPresensi> createState() => _StatusPresensiState();
}

class _StatusPresensiState extends State<StatusPresensi> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              Image.asset(
                "assets/images/login.webp",
                height: 150,
                width: 150,
              ),
              Text(
                "Status Presensi",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromRGBO(4, 4, 4, 1),
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 0),
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
                                  hintText: 'Nik Siswa',
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
                              SizedBox(height: 30),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
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
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Colors
                                                  .red; // Color when the button is pressed.
                                            }
                                            return Color.fromARGB(255, 20, 215,
                                                88); // Default color for the button.
                                          },
                                        ),
                                      ),
                                      onPressed: () => null,
                                      child: Text('Chceck',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
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
                                              return Color.fromARGB(
                                                  255,
                                                  43,
                                                  194,
                                                  108); // Default color for the button.
                                            },
                                          ),
                                        ),
                                        onPressed: () => {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/login',
                                                  (route) => false),
                                            },
                                        child: Text('Batal',
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ),
                                ],
                              ),
                              SizedBox(height: 100),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
