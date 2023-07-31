import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        onPageStarted: (String url) {
          setState(() {
            _loading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _loading = false;
          });
          if (_loading) {
            const CircularProgressIndicator();
          }
        },
        initialUrl: 'https://iiewp.csb.app/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
