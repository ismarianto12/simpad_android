import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Middleware {
  static Future<dynamic> getParams(String? params) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String prefdata = pref.getString("${params}").toString();
    return prefdata;
  }

  static checkCon(context) async {
    try {
      final result = await InternetAddress.lookup('flutterback.gotrain.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Silahkan Check kembali koneksi anda'),
        ),
      );
    }
  }
}
