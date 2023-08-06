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
    super.initState();
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
        ],
      ),
      body: SfPdfViewer.network(
        APP_API + '/v1/api/tandaterima/${widget.paramid}',
        key: _pdfViewerKey,
      ),
    );
  }
}
