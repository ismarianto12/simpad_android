import 'package:flutter/material.dart';
import 'dart:async';

class SliderDepanDash extends StatefulWidget {
  const SliderDepanDash({super.key});

  @override
  State<SliderDepanDash> createState() => _SliderDepanDashState();
}

class _SliderDepanDashState extends State<SliderDepanDash> {
  PageController _pageController = PageController();

  final List<Map<String, dynamic>> dataImage = [
    {
      "text": "Kelola Presensi Lebih Mudah",
      "image":
          "https://cinere.sekolah-avicenna.sch.id/wp-content/uploads/2021/11/TEMPLATE-PRESTASI-1000-x-400-px-1-990x400.png"
    },
    {
      "text": "Menggunakan QRCODE",
      "image":
          "https://cinere.sekolah-avicenna.sch.id/wp-content/uploads/2021/11/TEMPLATE-PRESTASI-1000-x-400-px-2-990x400.png"
    },
    {
      "text": "Langsung Ke Wa Wali Murid",
      "image":
          "https://cinere.sekolah-avicenna.sch.id/wp-content/uploads/2022/10/web-banner-cinere-990x400.png"
    },
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
        curve: Curves.bounceOut,
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
          return Container(
            width: 50,
            // padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 30, 94, 223),
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    dataImage[index]["image"],
                    height: MediaQuery.sizeOf(context).width * 0.300,
                    width: MediaQuery.sizeOf(context).width * 0.250,
                  ),
                  // Text(
                  //   dataImage[index]["text"],
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 15,
                  //     color: Color.fromARGB(255, 255, 255, 255),
                  //   ),
                  // ),
                ],
              ),
            ),
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
