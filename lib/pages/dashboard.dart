import 'package:flutter/material.dart';
import 'package:simpad_flutter/components/menu.dart';
import 'package:simpad_flutter/pages/login.dart';
import '../components/menuitems.dart';
import 'package:flutter_charts/flutter_charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  final tglsekarang = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                background_container(context),
                Positioned(top: 120, child: main_container()),
              ],
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.network(
                    'https://static.vecteezy.com/system/resources/previews/010/896/688/original/menu-icon-sign-symbol-design-free-png.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: Text(
                      "Menu Utama",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), //border corner radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 0, //spread radius
                    blurRadius: 0, // blur radius
                    offset: Offset(0, 6), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                  //you can set more BoxShadow() here
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    // Your grid items
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/lapor_sptpd');
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.network(
                              "https://static.vecteezy.com/system/resources/previews/010/146/533/original/tax-icon-sign-symbol-design-free-png.png",
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(height: 10),
                            Text('SPTPD')
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/list_sptpd');
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/spt.png",
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(height: 10),
                            Text('List SPTPD')
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/riwayat_bayar');
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.network(
                              "https://static.vecteezy.com/system/resources/previews/010/148/344/original/tax-icon-sign-symbol-design-free-png.png",
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(height: 10),
                            Text('Riwayat Bayar')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.network(
                    'https://static.vecteezy.com/system/resources/previews/010/896/688/original/menu-icon-sign-symbol-design-free-png.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Total PAD Lapor Pertanggal :",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        Text('${tglsekarang}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                // color: Colors.white,
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(30), //border corner radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 0, //spread radius
                        blurRadius: 0, // blur radius
                        offset: Offset(0, 6), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  child: ListTile(
                    title: Text('Total Pad'),
                    subtitle: Text('10.000'),
                    trailing: Icon(Icons.next_plan),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Rest of your code...

  Container main_container() {
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
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ' P12342423422',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                'PAJAK :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                ' HOTEL',
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
                      'Lapor E-SPTPD',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),

                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pop();
                        Route route = MaterialPageRoute(
                            builder: (context) => const Login());

                        Navigator.push(context, route);
                      },
                      child: Container(
                        color: Colors.green,
                        child: Icon(
                          Icons.login_outlined,
                          color: Colors.white,
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
                  Text(
                    'Hy Rian Welcome',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'tahoma',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
