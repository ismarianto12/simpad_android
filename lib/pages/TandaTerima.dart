import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:simpad_flutter/env.dart';

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
    print(APP_API + '/v1/api/tandaterima/' + widget.paramid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanda Terima'),
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
        ],
      ),
      body: SfPdfViewer.network(
        APP_API + '/v1/api/tandaterima/${widget.paramid}',
        key: _pdfViewerKey,
      ),
    );
  }
}
