import 'package:flutter/material.dart';
import 'package:presensi_app/pages/Jadwal.dart';
import 'package:presensi_app/pages/kartuAbsen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presensi_app/components/SliderDepanDash.dart';
import 'package:presensi_app/components/menu.dart';
import 'package:presensi_app/pages/CaraBayar.dart';
import 'package:presensi_app/pages/CetakKartuWp.dart';
import 'package:presensi_app/pages/login.dart';
import 'package:presensi_app/pages/scapresensi.dart';
import 'package:presensi_app/utils/middleware.dart';
import 'package:unicons/unicons.dart';
import '../components/menuitems.dart';
import 'package:flutter_charts/flutter_charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  String getusername = '';
  String getpajakname = '';

  Future<String?> _username() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String getlisusername = pref.getString('username').toString();
    String getpajakname = pref.getString("pajakname").toString();

    setState(() {
      getusername = getlisusername;
      getpajakname = getpajakname;
    });
  }

  @override
  void initState() {
    super.initState();
    _username();
  }

  final tglsekarang = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 132, 229),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                background_container(context),
                Positioned(
                    top: 120, child: main_container(getusername, getpajakname)),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  // height: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 6, 132, 229),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      // end: Alignment.topLeft,
                      colors: [Colors.blue, Colors.purple],
                    ),
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //       "https://img.freepik.com/premium-vector/illustration-vector-graphic-cartoon-character-digital-map_516790-244.jpg?w=360"),
                    //   fit: BoxFit.fill,
                    //   alignment: Alignment.topCenter,
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 19.0, left: 19.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E- Presensis QR ',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'tahoma',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        'Mon, 29 Oct 2024 23:24',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'tahoma',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 10.0, right: 10.0),
                  child: Expanded(child: SliderDepanDash()),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 100,
                    height: MediaQuery.of(context).size.height * 0.30,
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
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 10,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 231, 231),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              children: [
                                // Your grid items
                                InkWell(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                      builder: (context) => Jadwal(),
                                    );
                                    Navigator.push(context, route);
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.network(
                                          "https://img.freepik.com/premium-vector/id-card-icon-comic-style-identity-badge-vector-cartoon-illustration-pictogram-access-cardholder-people-business-concept-splash-effect_157943-5425.jpg",
                                          height: 50,
                                          width: 50,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Jadwal',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                      builder: (context) => KartuAbsen(),
                                    );
                                    Navigator.push(context, route);
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image.network(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYb0GAUp5UOA2bN5uoToApx9_kVFHu613h9beE5JU1CiHC3IhJhLRsmQ53znBa2kdPMks&usqp=CAU",
                                          height: 50,
                                          width: 50,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Cetak Kartu',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                      builder: (context) => ScanPresensi(),
                                    );
                                    Navigator.push(context, route);
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          UniconsLine.qrcode_scan,
                                          size:
                                              MediaQuery.sizeOf(context).width *
                                                  0.15,
                                          color: Colors.red,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          'Scan Presensi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // InkWell(
                                //   onTap: () {
                                //     Navigator.pushNamed(
                                //         context, '/lapor_sptpd');
                                //   },
                                //   child: Container(
                                //     child: Column(
                                //       children: [
                                //         Image.network(
                                //           "https://static.vecteezy.com/system/resources/previews/010/146/533/original/tax-icon-sign-symbol-design-free-png.png",
                                //           height: 50,
                                //           width: 50,
                                //         ),
                                //         SizedBox(height: 10),
                                //         Text('SPTPD')
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.pushNamed(context, '/list_sptpd');
                                //   },
                                //   child: Container(
                                //     child: Column(
                                //       children: [
                                //         Image.asset(
                                //           "assets/images/spt.png",
                                //           height: 50,
                                //           width: 50,
                                //         ),
                                //         SizedBox(height: 10),
                                //         Text('List SPTPD')
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.pushNamed(
                                //         context, '/riwayat_bayar');
                                //   },
                                //   child: Container(
                                //     child: Column(
                                //       children: [
                                //         Image.network(
                                //           "https://static.vecteezy.com/system/resources/previews/010/148/344/original/tax-icon-sign-symbol-design-free-png.png",
                                //           height: 50,
                                //           width: 50,
                                //         ),
                                //         SizedBox(height: 10),
                                //         Text('Riwayat Bayar')
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
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
    );
  }
  // Rest of your code...

  Container main_container(getusername, pajakname) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 50,
      width: 380,
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "DR. SOBARI ROSYDIN - GURU",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                pajakname,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    // Example shows a demo-type data generated randomly in a range.
    chartData = RandomChartData.generated(chartOptions: chartOptions);
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 3, 95, 170),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Icon(Icons.arrow_back, color: Colors.white),
                    // ),
                    Text(
                      'Admin Panel - Guru',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),

                    GestureDetector(
                      onTap: () {
                        _showConfirmDeleteDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Icon(
                            Icons.login_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', '');
    pref.setString('userid', '');
    pref.setString('pajakname', '');
  }

  Future<void> _showConfirmDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Anda Yakin ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the delete operation here
                _logout();
                Navigator.of(context).pop();
                Route route =
                    MaterialPageRoute(builder: (context) => const Login());
                Navigator.push(context, route);

                // Close the dialog
              },
              child: Text('Ok', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
