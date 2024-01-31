import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:presensi_app/env.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TandaTerima extends StatefulWidget {
  final String paramid;
  TandaTerima({required this.paramid});

  @override
  _TandaTerima createState() => _TandaTerima();
}

class _TandaTerima extends State<TandaTerima> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _downloadPdf() async {
    var response = await http.get(
      Uri.parse(APP_API + '/v1/api/tandaterima/${widget.paramid}'),
    );

    if (response.statusCode == 200) {
      var dir = await getTemporaryDirectory();
      File file = File("${dir.path}/tanda_terima.pdf");
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF downloaded successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(APP_API + '/v1/api/tandaterima/' + widget.paramid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tanda Terima ${widget.paramid}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
              semanticLabel: 'Download',
            ),
            onPressed: _downloadPdf,
          ),
        ],
      ),
      body: SfPdfViewer.network(
        APP_API + '/v1/api/tandaterima/${widget.paramid}',
        key: _pdfViewerKey,
      ),
    );
  }
}
