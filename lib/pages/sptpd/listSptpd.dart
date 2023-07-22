import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

class ListSptpd extends StatefulWidget {
  const ListSptpd({Key? key}) : super(key: key);

  @override
  State<ListSptpd> createState() => _ListSptpdState();
}

class _ListSptpdState extends State<ListSptpd>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> createPdfAndShow(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Cetak Tanda Terima'),
        ),
      ),
    );

    final file = File('lib/example.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => createPdfAndShow(context),
          child: Text('Create and Show PDF'),
        ),
      ),
    );
  }
}
