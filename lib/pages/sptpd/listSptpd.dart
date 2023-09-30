import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:unicons/unicons.dart';

import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/widgets.dart' as pw;

class ListSptpd extends StatefulWidget {
  const ListSptpd({Key? key}) : super(key: key);

  @override
  State<ListSptpd> createState() => _ListSptpdState();
}

class _ListSptpdState extends State<ListSptpd>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map<String, dynamic>> data = [
    {'label': 'Hotel', 'value': 1.0},
    {'label': 'Restoran', 'value': 2.0},
    {'label': 'Hiburan', 'value': 3.0},
    {'label': 'Reklame', 'value': 4.0},
    {'label': 'Penerangan Jalan', 'value': 5.0},
    {'label': 'Parkir', 'value': 6.0},
    {'label': 'Sarang Burung Walet', 'value': 7.0},
    {'label': 'Pajak Bumi', 'value': 8.0},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Durasi animasi (2 detik)
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tinggi = MediaQuery.of(context).size.height * 0.30;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // set it to false
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 10, 56, 208),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/premium-vector/home-digital-online-study-concept_310941-72.jpg?w=2000"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.16),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 100,
                      height: MediaQuery.of(context).size.height * 20,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(UniconsLine.chart),
                                Text(
                                  'Grafik PAD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                // Gunakan nilai animasi untuk menggerakkan grafik batang
                                final offset = _controller.value * tinggi;

                                return Column(
                                  children: [
                                    Card(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.30,
                                        child: Expanded(
                                          child: BarChart(
                                            BarChartData(
                                              titlesData: FlTitlesData(
                                                bottomTitles: SideTitles(
                                                  showTitles: true,
                                                  getTextStyles: (context,
                                                          value) =>
                                                      const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 82, 82, 82),
                                                          fontSize: 6),
                                                  margin: 10,
                                                  getTitles: (double value) {
                                                    switch (value.toInt()) {
                                                      case 0:
                                                        return 'Hotel';
                                                      case 1:
                                                        return 'Restoran';
                                                      case 2:
                                                        return 'Hiburan';
                                                      case 3:
                                                        return 'Reklame';
                                                      case 4:
                                                        return 'Penerangan';
                                                      case 5:
                                                        return 'Parkir';
                                                      case 6:
                                                        return 'Sarang Burung';
                                                      case 7:
                                                        return 'Pajak Bumi';
                                                      default:
                                                        return '';
                                                    }
                                                  },
                                                ),
                                                leftTitles: SideTitles(
                                                    showTitles: false),
                                              ),
                                              borderData:
                                                  FlBorderData(show: false),
                                              barGroups: [
                                                BarChartGroupData(
                                                  x: 0,
                                                  barRods: [
                                                    BarChartRodData(y: 20)
                                                  ],
                                                ),
                                                BarChartGroupData(
                                                  x: 1,
                                                  barRods: [
                                                    BarChartRodData(y: 30)
                                                  ],
                                                ),
                                                BarChartGroupData(
                                                  x: 2,
                                                  barRods: [
                                                    BarChartRodData(y: 50)
                                                  ],
                                                ),
                                                BarChartGroupData(
                                                  x: 3,
                                                  barRods: [
                                                    BarChartRodData(y: 40)
                                                  ],
                                                ),
                                                BarChartGroupData(
                                                  x: 4,
                                                  barRods: [
                                                    BarChartRodData(y: 25)
                                                  ],
                                                ),
                                                BarChartGroupData(
                                                  x: 5,
                                                  barRods: [
                                                    BarChartRodData(y: 10)
                                                  ],
                                                ),
                                                BarChartGroupData(
                                                  x: 6,
                                                  barRods: [
                                                    BarChartRodData(y: 15)
                                                  ],
                                                ),
                                                BarChartGroupData(
                                                  x: 7,
                                                  barRods: [
                                                    BarChartRodData(y: 35)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Card(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.30,
                                        child: PieChart(
                                          PieChartData(
                                            sectionsSpace: 0,
                                            centerSpaceRadius: 30,
                                            sections: List.generate(
                                              data.length,
                                              (index) {
                                                return PieChartSectionData(
                                                  color: Color((0xFF167F67 +
                                                          index * 50))
                                                      .withOpacity(1.0),
                                                  value: data[index]['value'],
                                                  title: data[index]['label'],
                                                  radius: 100,
                                                  titleStyle: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
