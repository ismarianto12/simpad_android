import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presensi_app/components/navigate.dart';
import 'package:presensi_app/env.dart';
import 'package:presensi_app/pages/DownloadScreen.dart';
import 'package:presensi_app/utils/middleware.dart';
import 'dart:convert';

import '../../components/Datepicker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class LaporSptpd extends StatefulWidget {
  final dynamic idspt;
  LaporSptpd({this.idspt});

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

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    int currentyear = DateTime.now().year;

    if (widget!.idspt != null) {
      _CallApi(widget.idspt);
      print(widget!.idspt);

      print("Edit action");
    } else if (widget.idspt == null) {
      _nomorTeleponController.text = "";
      _omsetController.text = "";
      _jumlahLaporController.text = "";
      _instruksiKhususController.text = "";
    }
    // print("spt id ${widget.idspt}");
    // print("Add action");
    _username();
    _tahunController.text = currentyear.toString();
  }

  Future<String?> _username() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String getlisusername = pref.getString('username').toString();
    setState(() {
      npwpd = getlisusername;
    });
  }

  String? filePath;
  String? serverFile;
  String? npwpd;

  String? filename;
  String? selectedMonth;
  String? _action;
  String? sptpdid;
  int? month;

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
    'Maret',
    'April',
    'May',
    'Juni',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Loading...',
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
              SizedBox(
                width: 30,
              ),
              CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    if (_loading) {
      Navigator.of(context).pop();
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _CallApi(idspt) async {
    String idwp = await Middleware.getParams("userid");
    final url = Uri.parse(APP_API + '/v1/api/sptpd/edit'); //v1/api
    var res = await http.post(
      url,
      body: {"wpid": idwp, "sptpdid": idspt.toString()},
    );
    print(res.body);
    if (res.statusCode == 200) {
      int currentyear = DateTime.now().year;
      var respondata = jsonDecode(res.body);

      String datetime = respondata['tanggal_lapor'];
      List<String> lisdata = datetime.split("-");
      month = int.parse(lisdata[1]);

      setState(() {
        _action = "edit";
        sptpdid = respondata['id'].toString();
        serverFile = respondata['bukti_bayar'].toString();
        _nomorTeleponController.text = "0"; // Convert int to string
        _omsetController.text = respondata['omset'].toString();
        _jumlahLaporController.text = respondata["jumlah"].toString();
        _instruksiKhususController.text = respondata["keterangan"].toString();
      });
    } else {
      final snackBar = SnackBar(
        content: Text('${res.body}'),
        // duration: Duration(
        //     seconds:
        //         3), // Optional: Control how long the Snackbar will be displayed
        // action: SnackBarAction(
        //   label: 'Close',
        //   onPressed: () {},
        // ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
    String username = await Middleware.getParams("username");
    String wpid = await Middleware.getParams("userid");
    print("userid ${wpid}");
    if (_formKey.currentState!.validate()) {
      _showLoadingDialog();

      var apiUrl = _action == 'edit'
          ? APP_API + '/v1/api/sptpd/update/'
          : APP_API + '/v1/api/sptpd/simpanSptpd';

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['nama'] = _namaController.text;
      request.fields['hp'] = _nomorTeleponController.text;
      request.fields['omset'] = _omsetController.text;
      request.fields['jumlahlapor'] = _jumlahLaporController.text;
      request.fields['instruksi'] = _instruksiKhususController.text;
      request.fields['tahun'] = _tahunController.text;
      request.fields['idwp'] = wpid;

      request.fields['npwpd'] = username;
      if (_action == 'edit') {
        request.fields['sptpdid'] = sptpdid.toString();
      }
      if (filePath != null) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath!));
      } else {
        _hideLoadingDialog();
        setState(() {
          _loading = false;
        });
      }
      print(request.fields);
      final response = await request.send();
      String responseBody =
          await response.stream.transform(utf8.decoder).join();
      print("response ${responseBody}");
      if (response.statusCode == 200) {
        final snackBar = SnackBar(
          content: const Text('Data Data Pad Berhasil di laporkan'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushNamedAndRemoveUntil(
            context, '/dashboard_panel', (route) => false);
      } else {
        setState(() {
          _loading = false;
        });
        SnackBar(
          content: const Text('Gagal menyimpan data'),
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
        margin: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                minWidth: 160,
                color: Color.fromARGB(255, 139, 187, 17), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: _simpanData,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      Text(
                        widget!.idspt != null ? "Edit" : 'Tambah',
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
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
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
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/premium-vector/smartphone-ui-ux-design-concept-application_73903-155.jpg"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 8,
                    // top: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => Navigate());
                              Navigator.push(context, route);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Kembali",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              widget!.idspt != null
                                  ? "Edit SPTPD"
                                  : 'Tambah SPTPD',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.16),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 100,
                      height: MediaQuery.of(context).size.height - 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 20,
                        width: MediaQuery.of(context).size.width * 20,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              height: 10,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 231, 231, 231),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 201, 200, 200),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                top: 5,
                                                bottom: 0),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              underline: Container(),
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: const Color.fromARGB(
                                                    255, 201, 200, 200),
                                              ),
                                              value: _action == 'edit'
                                                  ? months[month! - 1]
                                                  : selectedMonth,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedMonth = newValue;
                                                });
                                              },
                                              items: months.map<
                                                      DropdownMenuItem<String>>(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          child: TextFormField(
                                            controller: _tahunController,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              labelText: 'Tahun',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 16.0),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16.0),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // Text('Untuk biaya peminjaman per hari adalah 30.0000'),
                                    // SizedBox(height: 20),
                                    TextFormField(
                                      controller: _instruksiKhususController,
                                      decoration: InputDecoration(
                                        labelText: 'Catatan Tambahan',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),

                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.99,
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
                                                  20,
                                                  215,
                                                  88); // Default color for the button.
                                            },
                                          ),
                                        ),
                                        onPressed: () => pickFile(),
                                        child: Text('Upload FIle',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    if (_action == 'edit')
                                      GestureDetector(
                                        child: Text('Download file'),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DownloadScreen(
                                                      Npwpd: npwpd,
                                                      serverFile: serverFile),
                                            ),
                                          );
                                        },
                                      ),
                                    SizedBox(height: 5),
                                    _getFielStat(filename),
                                  ],
                                ),
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

  Widget _getFielStat(filename) {
    return filename != null && filename.isNotEmpty
        ? Text(
            "File name: " + filename.toString(),
            style: TextStyle(fontWeight: FontWeight.w200),
          )
        : Text(
            "No file selected",
            style: TextStyle(fontWeight: FontWeight.w200),
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
