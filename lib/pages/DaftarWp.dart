import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DaftarWp extends StatefulWidget {
  const DaftarWp({super.key});

  @override
  State<DaftarWp> createState() => _DaftarWpState();
}

class _DaftarWpState extends State<DaftarWp> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/login");
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black, // Set the icon color to black
          ),
        ),
        title: Text(
          "Daftar wajib pajak",
          style: TextStyle(
            color: Colors.black, // Set the text color to black
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        elevation: 0, // Remove the box shadow from AppBar
      ),
      body: Stack(
        children: [
          WebView(
            onPageStarted: (String url) {
              setState(() {
                _loading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _loading = false;
              });
            },
            initialUrl: 'https://pajak.gotrain.id/v1/api/wajib_pajak_view',
            javascriptMode: JavascriptMode.unrestricted,
          ),
          if (_loading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
