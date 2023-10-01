import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:simpad_flutter/utils/middleware.dart';
import 'dart:io';
import 'dart:convert';
import 'package:unicons/unicons.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import '../env.dart';

class RiwayatBayar extends StatefulWidget {
  const RiwayatBayar({Key? key}) : super(key: key);

  @override
  State<RiwayatBayar> createState() => _RiwayatBayarState();
}

class _RiwayatBayarState extends State<RiwayatBayar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Map<String, dynamic>> _data = [];

  Future<List<Map<String, dynamic>>> fgetchData() async {
    String wpdid = await Middleware.getParams("userid");
    var url = Uri.parse(APP_API + "/v1/api/sptpd/apiSptpd");
    http.Response resdata = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"loginid": wpdid},
    );
    // print('Response Data: ${resdata.body}');

    return List<Map<String, dynamic>>.from(json.decode(resdata.body));
  }

  @override
  void initState() {
    super.initState();
    fgetchData().then((data) {
      setState(() {
        _data = data; // Menggunakan assignment =, bukan _data: data;
      });
      print('Data from API: $_data');
    });
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
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    top: 20.0,
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  UniconsLine.list_ui_alt,
                                  size: 30,
                                ),
                                Text(
                                  'Data Bayar PAD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Center(
                            //   child: Text("${_data}"),
                            // ),

                            for (var item in _data)
                              Card(
                                child: ListTile(
                                  title: Text(
                                      item['ntb']?.toString() ?? 'No Data'),
                                  trailing: Text(item["keterangan"]),
                                ),
                              ),
                            // ListView.builder(
                            //   itemCount: _data.length,
                            //   itemBuilder: (context, index) {
                            //     final item = _data[index];
                            //     final ntb = item['ntb'];
                            //     return ListTile(
                            //       title: Text(ntb?.toString() ?? 'No Data'),
                            //     );
                            //   },
                            // )
                            // Expanded(
                            //   child: Row(
                            //     children: [
                            //       for (var item in _data)
                            //         ListTile(
                            //           title: Text(
                            //               item['ntb']?.toString() ?? 'No Data'),
                            //         ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
void dispose() {}
