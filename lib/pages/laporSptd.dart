import 'package:flutter/material.dart';

class LaporSptpd extends StatefulWidget {
  const LaporSptpd({super.key});

  @override
  State<LaporSptpd> createState() => _LaporSptpdState();
}

class _LaporSptpdState extends State<LaporSptpd> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  // final  _scaffoldkey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TEST')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Text('Lapor SPTPD'),
        ]),
      )),
    );
  }
}
