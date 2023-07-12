import 'package:flutter/material.dart';

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
          children: [
            Stack(alignment: AlignmentDirectional.center, children: [
              background_container(context),
              Positioned(top: 120, child: main_container()),
            ]),
            Container(
              child: Image.network(
                  "https://frconsultantindonesia.com/images/others/Jasa-Pajak.webp",
                  height: 200,
                  width: 200),
            ),
          ],
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 150,
      width: 380,
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: Row(
              children: [
                Text(
                  'NPWPD          :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' P12342423422',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  'Kecmatan   :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' Bogarasa',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: Row(
              children: [
                Text(
                  'Object Pajak :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' HOTEL',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Image.network(
                //     "https://png.pngtree.com/png-vector/20210927/ourmid/pngtree-tax-fund-mobile-tax-payment-png-image_3947210.png",
                //     height: 100,
                //     width: 100)
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            top: 500,
            child: Image.network(
                "https://frconsultantindonesia.com/images/others/Jasa-Pajak.webp",
                height: 200,
                width: 200),
          )
        ],
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
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
                      'Dashboard Panel',
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
