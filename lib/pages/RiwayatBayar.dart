import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

class RiwayatBayar extends StatefulWidget {
  const RiwayatBayar({Key? key}) : super(key: key);

  @override
  State<RiwayatBayar> createState() => _RiwayatBayarState();
}

class _RiwayatBayarState extends State<RiwayatBayar>
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/dashboard");
          },
          child: Icon(Icons.home)),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // set it to false
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // width: double.infinity,
                    // height: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://w0.peakpx.com/wallpaper/135/359/HD-wallpaper-ios-13-apple-2019-green-gradient-abstract.jpg"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.26),
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
                            SizedBox(height: 12),
                            Text(
                              'Data Bayar PAD',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Hotel'),
                                subtitle: Text('Lorem lipsum'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Restoran'),
                                subtitle: Text('Lorem lipsum'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Hiburan'),
                                subtitle: Text('Lorem lipsum'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Reklame'),
                                subtitle: Text('Lorem lipsum'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Penerangan Jalan'),
                                subtitle: Text('Lorem lipsum'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Parkir'),
                                subtitle: Text('Lorem Lipsum'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Sarang Burung Walet'),
                                subtitle: Text('Lorem lipsum'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('Lorem lipsum'),
                                subtitle: Text('Pajak Bumi'),
                              ),
                            ),
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
