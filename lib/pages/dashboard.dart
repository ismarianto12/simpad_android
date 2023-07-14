import 'package:flutter/material.dart';
import 'package:simpad_flutter/components/menu.dart';
import '../components/menuitems.dart';
import 'package:flutter_charts/flutter_charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
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
            Center(
                child: Text(
              "Menu Utama",
              style: TextStyle(fontSize: 18.0),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    // Your grid items
                    Container(
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
                    Container(
                      child: Column(
                        children: [
                          Image.network(
                            "https://bangun-rumah.com/wp-content/uploads/survey-icon-12.png",
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(height: 10),
                          Text('List SPTPD')
                        ],
                      ),
                    ),
                    Container(
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Center(
              child: Text(
                "Statistik.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Center(
              child: Text(
                "Jumlah.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text('Total Pad'),
                  subtitle: Text('10.000'),
                  trailing: Icon(Icons.skip_next),
                ),
              ),
            ),
            // Expanded(child: chartToRun()),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      'Lapor E-SPTPD',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
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
        ),
      ],
    );
  }
}
