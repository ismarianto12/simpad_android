import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _namaBarangController = TextEditingController();
  TextEditingController _deskripsiBarangController = TextEditingController();
  TextEditingController _tanggalPenitipanController = TextEditingController();
  TextEditingController _durasiPenitipanController = TextEditingController();
  TextEditingController _biayaPenitipanController = TextEditingController();
  TextEditingController _instruksiKhususController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  String? filePath;
  String? filename;
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path!;
      });

      // Pass the file to the API
      // await uploadFile(filePath!);
    }
  }

  void _hitungBiayaPenitipan() {
    DateTime tglHariIni = DateTime.now();
    String formattedDate = _tanggalPenitipanController.text;
    DateTime tglPengembalian = DateTime(
      int.parse(formattedDate.substring(6)), // Year
      int.parse(formattedDate.substring(3, 5)), // Month
      int.parse(formattedDate.substring(0, 2)), // Day
    );
    Duration durasiPenitipan = tglPengembalian.difference(tglHariIni);
    int totalHari = durasiPenitipan.inDays + 1;
    int biayaPenitipan = totalHari * 10000;

    _durasiPenitipanController.text = totalHari.toString() + ' Hari';
    _biayaPenitipanController.text = biayaPenitipan.toString();
  }

  void _simpanData() async {
    if (_formKey.currentState!.validate()) {
      // var response = await http.post(url, body: {
      //   'nama': _namaController.text,
      //   'nomorTelepon': _nomorTeleponController.text,
      //   'alamat': _alamatController.text,
      //   'namaBarang': _namaBarangController.text,
      //   'deskripsiBarang': _deskripsiBarangController.text,
      //   'tanggalPenitipan': _tanggalPenitipanController.text,
      //   'durasiPenitipan': _durasiPenitipanController.text,
      //   'biayaPenitipan': _biayaPenitipanController.text,
      //   'instruksiKhusus': _instruksiKhususController.text,
      // });
      //     response.files.add(await http.MultipartFile.fromPath('file', path));

      // print(response.body);

      String apiUrl =
          'https://example.com/upload'; // Replace with your API endpoint
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      // File file = filePath!);
      // String fileName = filename!;
      // request.files.add(await http.MultipartFile.fromPath('file', filePath));
      if (filePath != null) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath!));
      } else {
        // Handle the case when `filePath` is null
      }

      request.fields['additionalData'] = _tanggalPenitipanController.text;
      http.StreamedResponse response = await request.send();
      print("${response}");
      if (response.statusCode == 200) {
        // SnackBar(
        //   content: Text('Data berhasil disimpan'),
        // );
        // Navigator.pushNamed(context, '/penitipanlist');
      } else {
        // SnackBar(
        //   content: Text('Gagal menyimpan data'),
        // );
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
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (route) => false);
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
                      Datepicker(
                        controller: _tanggalPenitipanController,
                        onDateSelected: (DateTime selectedDate) {
                          _hitungBiayaPenitipan();
                        },
                        label: 'Tanggal Lapor',
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
                        controller: _instruksiKhususController,
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
                      TextFormField(
                        controller: _instruksiKhususController,
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
                        // alignment: Alignment.center,
                        width: 300,
                        child: MaterialButton(
                          color: Color.fromARGB(
                              255, 87, 89, 82), // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onPressed: pickFile,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Icon(
                                  Icons.file_copy,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Pilih File',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 100),
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

  @override
  void dispose() {
    _namaController.text;
    _nomorTeleponController.text;
    _alamatController.text;
    _namaBarangController.text;
    _deskripsiBarangController.text;
    _tanggalPenitipanController.text;
    _durasiPenitipanController.text;
    _biayaPenitipanController.text;
    _instruksiKhususController.text;
    super.dispose();
  }
}
