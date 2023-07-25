import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class CetakSptd extends StatefulWidget {
  @override
  _CetakSptdState createState() => _CetakSptdState();
}

class _CetakSptdState extends State<CetakSptd> {
  final sampleUrl =
      'https://www.researchgate.net/profile/Suhendro-Irianto/publication/311708107_PENGOLAHAN_CITRA_DIGITAL/links/58565f7408aeff086bfbb3b4/PENGOLAHAN-CITRA-DIGITAL.pdf';

  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(sampleUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            if (pdfFlePath != null)
              Expanded(
                child: Container(
                  child: PdfView(path: pdfFlePath!),
                ),
              )
            else
              Text("Pdf is not Loaded"),
          ],
        ),
      ),
    );
  }
}
