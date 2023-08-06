import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DownloadScreen extends StatefulWidget {
  final dynamic serverFile;
  final dynamic Npwpd;

  DownloadScreen({required this.serverFile, required this.Npwpd});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool _loading = true;
  String getusername = '';

  Future<String?> _username() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String getlisusername = pref.getString('username').toString();
    String getpajakname = pref.getString('pajakname').toString();

    setState(() {
      getusername = getlisusername;
      getpajakname = getpajakname;
    });
  }

  void initState() {
    _username();
    print('response gambar');
    print(
        'https://pajak.gotrain.id/asset/esptpd/${getusername}/${widget.serverFile}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black, // Set the icon color to black
          ),
        ),
        title: Text(
          "Detail ${getusername} ${widget.serverFile}",
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
            initialUrl:
                'https://pajak.gotrain.id/asset/esptpd/P210311032321/${widget.serverFile}',
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
