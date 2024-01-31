import 'package:flutter/material.dart';
import 'dart:async';

class SliderDepan extends StatefulWidget {
  const SliderDepan({super.key});

  @override
  State<SliderDepan> createState() => _SliderDepanState();
}

class _SliderDepanState extends State<SliderDepan> {
  PageController _pageController = PageController();

  final List<Map<String, dynamic>> dataImage = [
    {
      "text": "Kelola Presensi Lebih Mudah",
      "image": "assets/images/pantek.png"
    },
    {"text": "Menggunakan QRCODE", "image": "assets/images/finger.png"},
    {"text": "Langsung Ke Wa Wali Murid", "image": "assets/images/login.webp"},
  ];

  int _currentpage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentpage < dataImage.length - 1) {
        _currentpage++;
      } else {
        _currentpage = 0;
      }
      _pageController.animateToPage(
        _currentpage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).width * 0.30,
      child: PageView.builder(
        controller: _pageController,
        itemCount: dataImage.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.asset(
                dataImage[index]["image"],
                height: 100,
                width: 100,
              ),
              Text(
                dataImage[index]["text"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          );
        },
        onPageChanged: (int page) {
          setState(() {
            _currentpage = page;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
