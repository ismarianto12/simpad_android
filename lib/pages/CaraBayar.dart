import 'package:flutter/material.dart';
import 'package:presensi_app/components/navigate.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CaraBayar extends StatefulWidget {
  const CaraBayar({super.key});

  @override
  State<CaraBayar> createState() => _CaraBayarState();
}

class _CaraBayarState extends State<CaraBayar> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        leading: GestureDetector(
          onTap: () {
            // Navigator.pushReplacementNamed(context, "/dasboard_panel");
            Route route = MaterialPageRoute(
              builder: (context) => Navigate(),
            );
            Navigator.push(context, route);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black, // Set the icon color to black
          ),
        ),
        title: Text(
          "Cara Bayar SPTPD",
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
            initialUrl: 'https://pajak.gotrain.id/v1/api/sptpd/carabayar',
            javascriptMode: JavascriptMode.unrestricted,
          ),
          if (_loading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(),
                  Text('Mohon Bersabar Sedang Meload data...')
                ],
              ),
            ),
        ],
      ),
    );
  }
}
