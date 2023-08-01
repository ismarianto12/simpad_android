import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

class ListSptpd extends StatefulWidget {
  const ListSptpd({Key? key}) : super(key: key);

  @override
  State<ListSptpd> createState() => _ListSptpdState();
}

class _ListSptpdState extends State<ListSptpd>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tinggi = MediaQuery.of(context).size.height * 0.30;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/premium-vector/home-digital-online-study-concept_310941-72.jpg?w=2000"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.26),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 100,
                        height: MediaQuery.of(context).size.height * 0.100,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Laporan PAD',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ]),
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
