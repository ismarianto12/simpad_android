import 'package:flutter/material.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.blueAccent,
      //   title: Text(
      //     "Jadwal Guru",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: Column(
        children: [
          main_container("Dr. Sobari MM", "ada"),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return buildListItem(index.toString());
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(String item) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(
            item,
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text("Jadwal"),
      ),
    );
  }

  Container main_container(getusername, username) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 100,
      height: 130,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
        color: Color.fromARGB(255, 12, 125, 218),
      ),
      child: Column(
        children: [
          SizedBox(height: 32),
          Text(getusername,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          Text(username, style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
