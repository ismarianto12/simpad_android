import 'package:flutter/material.dart';
import 'package:presensi_app/pages/ActionPage.dart';
import 'package:presensi_app/pages/Chart.dart';
import 'package:presensi_app/pages/dashboard.dart';

import '../pages/Profile.dart';
import '../pages/laporSptpd.dart';
import '../pages/sptpd/listSptpd.dart';
import 'package:unicons/unicons.dart';

class Navigate extends StatefulWidget {
  const Navigate({Key? key}) : super(key: key);

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  int index_color = 0;
  List<Widget> screens = [
    Dashboard(),
    ListSptpd(),
    Chart(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: screens[index_color],
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.11,
        color: Color.fromARGB(255, 255, 255, 255),
        shape: CircularNotchedRectangle(),
        child: Container(
          height:
              kToolbarHeight, // Set ukuran tinggi BottomAppBar sesuai dengan kToolbarHeight
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: index_color == 0
                          ? BorderSide(
                              color: Colors
                                  .red, // Set the color of the bottom border
                              width: 2.0, // Set the width of the bottom border
                            )
                          : BorderSide(
                              color: Colors
                                  .transparent, // Set the color of the bottom border
                              width: 2.0, // Set the width of the bottom border
                            ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        UniconsLine.estate,
                        size: 30,
                        color:
                            index_color == 0 ? Colors.green : Colors.green[100],
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: index_color == 2
                          ? BorderSide(
                              color: Colors
                                  .red, // Set the color of the bottom border
                              width: 2.0, // Set the width of the bottom border
                            )
                          : BorderSide(
                              color: Colors
                                  .transparent, // Set the color of the bottom border
                              width: 2.0, // Set the width of the bottom border
                            ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        UniconsLine.list_ui_alt,
                        size: 30,
                        color:
                            index_color == 2 ? Colors.green : Colors.green[100],
                      ),
                      Text(
                        "Rerport Presensi",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: index_color == 3
                          ? BorderSide(
                              color: Colors
                                  .red, // Set the color of the bottom border
                              width: 2.0, // Set the width of the bottom border
                            )
                          : BorderSide(
                              color: Colors
                                  .transparent, // Set the color of the bottom border
                              width: 2.0, // Set the width of the bottom border
                            ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        UniconsLine.user,
                        size: 30,
                        color:
                            index_color == 3 ? Colors.green : Colors.green[100],
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
