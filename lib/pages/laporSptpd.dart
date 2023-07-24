import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpad_flutter/env.dart';
import 'package:simpad_flutter/utils/middleware.dart';
import 'dart:convert';

import '../../components/Datepicker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class LaporSptpd extends StatefulWidget {
  @override
  _LaporSptpdState createState() => _LaporSptpdState();
}

class _LaporSptpdState extends State<LaporSptpd> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _nomorTeleponController = TextEditingController();
  TextEditingController _omsetController = TextEditingController();

  // TextEditingController _alamatController = TextEditingController();
  // TextEditingController _namaBarangController = TextEditingController();
  // TextEditingController _deskripsiBarangController = TextEditingController();
  // TextEditingController _tanggalPenitipanController = TextEditingController();
  // TextEditingController _durasiPenitipanController = TextEditingController();
  // TextEditingController _biayaPenitipanController = TextEditingController();
  TextEditingController _jumlahLaporController = TextEditingController();

  TextEditingController _instruksiKhususController = TextEditingController();
  TextEditingController _tahunController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tahunController.text = "2023";
  }

  String? filePath;
  String? filename;
  String? selectedMonth;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path!;
      });
    }
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // void _hitungBiayaPenitipan() {
  //   DateTime tglHariIni = DateTime.now();
  //   String formattedDate = _tanggalPenitipanController.text;
  //   DateTime tglPengembalian = DateTime(
  //     int.parse(formattedDate.substring(6)), // Year
  //     int.parse(formattedDate.substring(3, 5)), // Month
  //     int.parse(formattedDate.substring(0, 2)), // Day
  //   );
  //   Duration durasiPenitipan = tglPengembalian.difference(tglHariIni);
  //   int totalHari = durasiPenitipan.inDays + 1;
  //   int biayaPenitipan = totalHari * 10000;

  //   _durasiPenitipanController.text = totalHari.toString() + ' Hari';
  //   _biayaPenitipanController.text = biayaPenitipan.toString();
  // }

  void _simpanData() async {
    String username = Middleware.getParams("username").toString();
    String wpid = Middleware.getParams("wpid").toString();

    if (_formKey.currentState!.validate()) {
      String apiUrl = APP_API +
          '/v1/api/sptpd/simpanSptpd'; // Replace with your API endpoint
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      // Add form fields
      request.fields['nama'] = _namaController.text;
      request.fields['hp'] = _nomorTeleponController.text;
      request.fields['omset'] = _omsetController.text;
      request.fields['jumlahlapor'] = _jumlahLaporController.text;
      request.fields['instruksi'] = _instruksiKhususController.text;
      request.fields['tahun'] = _tahunController.text;
      request.fields['idwp'] = wpid;
      request.fields['npwpd'] = username;

      if (filePath != null) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath!));
      } else {
        // Handle the case when `filePath` is null
      }
      final response = await request.send();
      String responseBody =
          await response.stream.transform(utf8.decoder).join();
      print("response ${responseBody}");
      if (response.statusCode == 200) {
        final snackBar = SnackBar(
          content: Text('Data Data Pad Berhasil di laporkan'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushNamedAndRemoveUntil(
            context, '/dashboard_panel', (route) => false);
      } else {
        SnackBar(
          content: Text('Gagal menyimpan data'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 70.0,
        color: Colors.white,
        margin: EdgeInsets.only(top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              minWidth: 160,
              color: Color.fromARGB(255, 139, 187, 17), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: _simpanData,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    Text(
                      'Simpan',
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              minWidth: 140,
              color: Color.fromARGB(255, 227, 179, 5), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.restore,
                      color: Colors.white,
                    ),
                    Text(
                      'Batal',
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard_panel', (route) => false);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        title: Text(
          'Form Report SPTPD',
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.width * 20,
            width: MediaQuery.of(context).size.width * 20,
            child: Column(
              children: [
                // Image.asset(
                //   "assets/images/loan_top.png",
                //   height: 200,
                //   width: 200,
                // ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // SizedBox(height: 20),
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwePPZvclrChuuZWVtDVSh29tIBoRScHrQhsWPo6jtIn8OjDwp1eNNbQ6-DVjr3yjenZo&usqp=CAU',
                          // height: 200,
                          // width: ,
                          fit: BoxFit.cover,
                        ),

                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 5, bottom: 0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: Container(),
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  value: selectedMonth,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedMonth = newValue;
                                    });
                                  },
                                  items: months.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: TextFormField(
                                controller: _tahunController,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Tahun',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        // TextFormField(
                        //   enabled: false,
                        //   controller: _durasiPenitipanController,
                        //   decoration: InputDecoration(
                        //     labelText: 'Pajak Bulan : ',
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8.0),
                        //     ),
                        //     contentPadding: EdgeInsets.symmetric(
                        //         vertical: 12.0, horizontal: 16.0),
                        //   ),
                        // ),
                        //  SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _omsetController,
                          decoration: InputDecoration(
                            labelText: 'Omset Per Bulan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _jumlahLaporController,
                          decoration: InputDecoration(
                            labelText: 'Jumlah Lapor',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Untuk biaya peminjaman per hari adalah 30.0000'),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _instruksiKhususController,
                          decoration: InputDecoration(
                            labelText: 'Catatan Tambahan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.99,
                          height: 40,
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
                            onPressed: () => pickFile(),
                            child: Text('Upload FIle',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "File name : " + filename.toString(),
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.text;
    _nomorTeleponController.text;
    _instruksiKhususController.text;
    filename;
    super.dispose();
  }
}
