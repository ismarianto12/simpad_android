import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:simpad_flutter/env.dart';
import 'package:simpad_flutter/utils/middleware.dart';

class ListSptpd extends StatefulWidget {
  @override
  _ListSptpdState createState() => _ListSptpdState();
}

class _ListSptpdState extends State<ListSptpd> {
  List<Map<String, dynamic>> _data = [];

  bool _loading = true;

  // [
  //   {
  //     'id': 1,
  //     'name': 'John Doe',
  //     'age': 25,
  //     'email': 'johndoe@example.com',
  //   },
  //   {
  //     'id': 2,
  //     'name': 'Jane Smith',
  //     'age': 30,
  //     'email': 'janesmith@example.com',
  //   },
  //   {
  //     'id': 3,
  //     'name': 'Alice Johnson',
  //     'age': 28,
  //     'email': 'alicejohnson@example.com',
  //   },
  //   // Add more data as needed
  // ];

  List<Map<String, dynamic>> _filteredData = [];

  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(_data);
    fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    String wpid = Middleware.getParams("wpid").toString();
    var url = Uri.parse(APP_API + "sptpd/listdata");
    http.Response resdata = await http.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"loginid": wpid});
    print("respinse ${resdata.body}");
    setState(() {
      _loading = false;
      _data = List<Map<String, dynamic>>.from(json.decode(resdata.body));
    });
    return _data;
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
      final name = row['name'].toString().toLowerCase();
      final email = row['email'].toString().toLowerCase();
      return name.contains(_searchText.toLowerCase()) ||
          email.contains(_searchText.toLowerCase());
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text('List Data SPTPD'),
      ),
      body: Column(
        children: [
          Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwePPZvclrChuuZWVtDVSh29tIBoRScHrQhsWPo6jtIn8OjDwp1eNNbQ6-DVjr3yjenZo&usqp=CAU',
            // height: 200,
            // width: ,
            fit: BoxFit.cover,
          ),
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
              child: _loading == false
                  ? CircularProgressIndicator()
                  : DataTable(
                      sortAscending: _sortAscending,
                      sortColumnIndex: _sortColumnIndex,
                      columns: [
                        DataColumn(
                          label: Text('ID'),
                          numeric: true,
                          onSort: (columnIndex, ascending) {
                            _sort<int>((d) => d['id'], columnIndex, ascending);
                          },
                        ),
                        DataColumn(
                          label: Text('Name'),
                          onSort: (columnIndex, ascending) {
                            _sort<String>(
                                (d) => d['name'], columnIndex, ascending);
                          },
                        ),
                        DataColumn(
                          label: Text('Age'),
                          numeric: true,
                          onSort: (columnIndex, ascending) {
                            _sort<int>((d) => d['age'], columnIndex, ascending);
                          },
                        ),
                        DataColumn(
                          label: Text('Email'),
                          onSort: (columnIndex, ascending) {
                            _sort<String>(
                                (d) => d['email'], columnIndex, ascending);
                          },
                        ),
                      ],
                      rows: _filteredData
                          .skip(0)
                          .take(_rowsPerPage)
                          .map((row) => DataRow(
                                cells: [
                                  DataCell(Text(row['id'].toString())),
                                  DataCell(Text(row['name'])),
                                  DataCell(Text(row['age'].toString())),
                                  DataCell(Text(row['email'])),
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
    );
  }
}
