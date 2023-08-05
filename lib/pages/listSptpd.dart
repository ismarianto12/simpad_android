import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    print("response ${resdata}");
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard_panel', (route) => false);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        title: Text(
          'List Data SPTPD',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(),
                  Text('Mohon Bersabar Sedang Meload data...')
                ],
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Adjust the width as needed

                child: Column(
                  // verticalDirection: ,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
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
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          sortAscending: _sortAscending,
                          sortColumnIndex: _sortColumnIndex,
                          columns: [
                            DataColumn(
                              label: Text('ID'),
                              numeric: true,
                              onSort: (columnIndex, ascending) {
                                _sort<int>(
                                    (d) => d['id'], columnIndex, ascending);
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
                                _sort<int>((d) => d['keterangan'], columnIndex,
                                    ascending);
                              },
                            ),
                            DataColumn(
                              label: Text('Jumlah Bayar'),
                              onSort: (columnIndex, ascending) {
                                _sort<String>(
                                    (d) => d['jumlah'], columnIndex, ascending);
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
                                      DataCell(Text(row['id'].toString())),
                                      DataCell(Text(row['ntb'])),
                                      DataCell(
                                          Text(row['keterangan'].toString())),
                                      DataCell(Text(row['jumlah'].toString())),
                                      row['status'].toString() == "4"
                                          ? DataCell(
                                              Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.20,
                                                    height: 35,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0), // Adjust the radius as needed
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateColor
                                                                  .resolveWith(
                                                            (states) {
                                                              if (states.contains(
                                                                  MaterialState
                                                                      .pressed)) {
                                                                return Colors
                                                                    .red; // Color when the button is pressed.
                                                              }
                                                              return Color.fromARGB(
                                                                  255,
                                                                  23,
                                                                  6,
                                                                  211); // Default color for the button.
                                                            },
                                                          ),
                                                        ),
                                                        child: Text('Print',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        onPressed: () => {
                                                              routePrint(
                                                                  context,
                                                                  row['id']
                                                                      .toString())
                                                            }
                                                        //Navigate To Login

                                                        ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : DataCell(
                                              Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.20,
                                                    height: 35,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0), // Adjust the radius as needed
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                          (states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .pressed)) {
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
                                                      onPressed: () => {
                                                        routeEdit(
                                                            context,
                                                            row['id'] ??
                                                                row['id'])
                                                      },
                                                      child: Text('Edit',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.20,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0), // Adjust the radius as needed
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateColor
                                                                  .resolveWith(
                                                            (states) {
                                                              if (states.contains(
                                                                  MaterialState
                                                                      .pressed)) {
                                                                return Colors
                                                                    .red; // Color when the button is pressed.
                                                              }
                                                              return Color.fromARGB(
                                                                  255,
                                                                  238,
                                                                  9,
                                                                  108); // Default color for the button.
                                                            },
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          _showConfirmDeleteDialog(
                                                              context);
                                                        },
                                                        child: Text('Delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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

Future<void> _showConfirmDeleteDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Anda yakin akan menghapus ini'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
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

void _performDeleteOperation() {
  // Implement your delete logic here
  // This function will be called when the user confirms the delete action
}
