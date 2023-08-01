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
        // title: Text(
        //   "Daftar wajib pajak",
        //   style: TextStyle(
        //     color: Colors.black, // Set the text color to black
        //     fontWeight: FontWeight.bold, // Make the text bold
        //   ),
        // ),
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
            initialUrl: 'https://pajak.gotrain.id/v1/api/android_dashboard',
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
