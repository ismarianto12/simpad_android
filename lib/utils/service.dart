import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:presensi_app/env.dart';
import 'package:presensi_app/utils/middleware.dart';

class Service {
  static Future<List<dynamic>> profile() async {
    var userid = Middleware.getParams('userid');

    var url = Uri.parse('${APP_API}/getprofile');
    var response = await http.post(url, headers: {
      'type': 'Application/json',
      'Token': 'null',
    }, body: {
      'user_id': userid
    });
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw (Exception('Error accessing API'));
    }
  }

  static void _saveProfile(List<String?> listdata, context) async {
    var url = Uri.parse(APP_API + '/saveprofile');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': '<PASSWORD>'
      },
      body: {
        'konfirmasi': listdata[0],
        'password': listdata[0],
        'email': listdata[2]
      },
    );
    if (response.statusCode == 200) {
      final snack = SnackBar(
        content: Text("Berhasil update data"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    } else {
      final snack = SnackBar(
        content: Text("Gagal update data"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }
}
