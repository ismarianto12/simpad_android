import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpad_flutter/components/navigate.dart';
import 'dart:convert';
import 'dart:io';
import 'package:simpad_flutter/env.dart';
import 'package:simpad_flutter/pages/TandaTerima.dart';
import 'package:simpad_flutter/pages/cetaksptpd.dart';
import 'package:simpad_flutter/pages/laporSptpd.dart';
import 'package:simpad_flutter/pages/login.dart';
import 'package:simpad_flutter/utils/middleware.dart';

class ListSptpd extends StatefulWidget {
  @override
  _ListSptpdState createState() => _ListSptpdState();
}

class _ListSptpdState extends State<ListSptpd> {
  List<Map<String, dynamic>> _data = [];
  bool _loading = true;
  List<Map<String, dynamic>> _filteredData = [];
  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  String _searchText = '';

  Future<List<Map<String, dynamic>>> fetchData() async {
    String wpid = await Middleware.getParams("userid");
    var url = Uri.parse(APP_API + "/v1/api/sptpd/apiSptpd");
    http.Response resdata = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"loginid": wpid},
    );

    return List<Map<String, dynamic>>.from(json.decode(resdata.body));
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((data) {
      setState(() {
        _loading = false;
        _data = data;
        _filteredData = List.from(_data);
      });
    });
  }

  void _sort<T>(Comparable<T> Function(Map<String, dynamic> d) getField,
      int columnIndex, bool ascending) {
    _filteredData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void _filterData() {
    _filteredData = _data.where((row) {
      final name = row['ntb'].toString().toLowerCase();
      final email = row['jumlah'].toString().toLowerCase();
      return name.contains(_searchText.toLowerCase()) ||
          email.contains(_searchText.toLowerCase());
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // width: double.infinity,
                    // height: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 10, 56, 208),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/premium-vector/smartphone-ui-ux-design-concept-application_73903-155.jpg"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => Navigate(),
                      );
                      Navigator.push(context, route);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Text(
                            "List data Bayar SPTPD",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                      child: SingleChildScrollView(
                        child: _loading
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(),
                                  Text('Mohon Bersabar Sedang Meload data...')
                                ],
                              )
                            : Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Adjust the width as needed

                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Cari',
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: () {
                                              setState(() {
                                                _searchText = '';
                                                _filterData();
                                              });
                                            },
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            _searchText = value;
                                            _filterData();
                                          });
                                        },
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        sortAscending: _sortAscending,
                                        sortColumnIndex: _sortColumnIndex,
                                        columns: [
                                          DataColumn(
                                            label: Text('ID'),
                                            numeric: true,
                                            onSort: (columnIndex, ascending) {
                                              _sort<int>((d) => d['id'],
                                                  columnIndex, ascending);
                                            },
                                          ),
                                          DataColumn(
                                            label: Text('NTB'),
                                            // onSort: (columnIndex, ascending) {
                                            //   _sort<String>(
                                            //       (d) => d['ntb'], columnIndex, ascending);
                                            // },
                                          ),
                                          DataColumn(
                                            label: Text('Keterangan'),
                                            numeric: true,
                                            onSort: (columnIndex, ascending) {
                                              _sort<int>((d) => d['keterangan'],
                                                  columnIndex, ascending);
                                            },
                                          ),
                                          DataColumn(
                                            label: Text('Jumlah Bayar'),
                                            onSort: (columnIndex, ascending) {
                                              _sort<String>((d) => d['jumlah'],
                                                  columnIndex, ascending);
                                            },
                                          ),
                                          DataColumn(
                                            label: const Text('Action'),
                                          ),
                                        ],
                                        rows: _filteredData
                                            .skip(0)
                                            .take(_rowsPerPage)
                                            .map((row) => DataRow(
                                                  cells: [
                                                    DataCell(Text(
                                                        row['id'].toString())),
                                                    DataCell(Text(row['ntb'])),
                                                    DataCell(Text(
                                                        row['keterangan']
                                                            .toString())),
                                                    DataCell(Text(row['jumlah']
                                                        .toString())),
                                                    row['status'].toString() ==
                                                            "4"
                                                        ? DataCell(
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.20,
                                                                  height: 35,
                                                                  child:
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            shape:
                                                                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                              RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                                                                              ),
                                                                            ),
                                                                            backgroundColor:
                                                                                MaterialStateColor.resolveWith(
                                                                              (states) {
                                                                                if (states.contains(MaterialState.pressed)) {
                                                                                  return Colors.red; // Color when the button is pressed.
                                                                                }
                                                                                return Color.fromARGB(255, 23, 6, 211); // Default color for the button.
                                                                              },
                                                                            ),
                                                                          ),
                                                                          child: Text(
                                                                              'Print',
                                                                              style: TextStyle(
                                                                                  color: Colors
                                                                                      .white)),
                                                                          onPressed: () =>
                                                                              {
                                                                                routePrint(context, row['id_esptpd'].toString())
                                                                              }
                                                                          //Navigate To Login

                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : DataCell(
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.20,
                                                                  height: 35,
                                                                  child:
                                                                      ElevatedButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0), // Adjust the radius as needed
                                                                        ),
                                                                      ),
                                                                      backgroundColor:
                                                                          MaterialStateColor
                                                                              .resolveWith(
                                                                        (states) {
                                                                          if (states
                                                                              .contains(MaterialState.pressed)) {
                                                                            return Colors.red; // Color when the button is pressed.
                                                                          }
                                                                          return Color.fromARGB(
                                                                              255,
                                                                              20,
                                                                              215,
                                                                              88); // Default color for the button.
                                                                        },
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () => {
                                                                      routeEdit(
                                                                          context,
                                                                          row['id_esptpd'] ??
                                                                              row['id_esptpd'])
                                                                    },
                                                                    child: Text(
                                                                        'Edit',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Container(
                                                                  height: 35,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.20,
                                                                  child:
                                                                      ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            shape:
                                                                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                              RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                                                                              ),
                                                                            ),
                                                                            backgroundColor:
                                                                                MaterialStateColor.resolveWith(
                                                                              (states) {
                                                                                if (states.contains(MaterialState.pressed)) {
                                                                                  return Colors.red; // Color when the button is pressed.
                                                                                }
                                                                                return Color.fromARGB(255, 238, 9, 108); // Default color for the button.
                                                                              },
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            _showConfirmDeleteDialog(context,
                                                                                row['id_sptpd']);
                                                                          },
                                                                          child: Text(
                                                                              'Delete',
                                                                              style: TextStyle(color: Colors.white))),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              "Silahkan Scrool dari kiri ke kana untuk melihat detail"),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          onPressed: () {
                                            setState(() {
                                              _rowsPerPage -= 10;
                                              if (_rowsPerPage < 10) {
                                                _rowsPerPage = 10;
                                              }
                                            });
                                          },
                                        ),
                                        Text('Rows per page: $_rowsPerPage'),
                                        IconButton(
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: () {
                                            setState(() {
                                              _rowsPerPage += 10;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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

routePrint(BuildContext context, String id) {
  Route route =
      MaterialPageRoute(builder: (context) => TandaTerima(paramid: id));
  Navigator.push(context, route);
}

routeEdit(BuildContext context, idspt) {
  Route route =
      MaterialPageRoute(builder: (context) => LaporSptpd(idspt: idspt));
  Navigator.push(context, route);
}

Future<void> _showConfirmDeleteDialog(BuildContext context, id) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Anda yakin akan menghapus ini'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _deleteData(id);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform the delete operation here
              _performDeleteOperation();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

void _deleteData(id) async {
  var uri = Uri.parse(APP_API + "/v1/api/delete/${id}");
  var response = await http.post(
    uri,
    body: {'toke': 'token'},
  );
  print('response debug ${response}');
}

void _performDeleteOperation() {
  // Implement your delete logic here
  // This function will be called when the user confirms the delete action
}
