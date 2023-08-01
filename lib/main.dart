import 'package:flutter/material.dart';
import 'package:simpad_flutter/components/navigate.dart';
import 'package:simpad_flutter/pages/login.dart';
import 'package:simpad_flutter/route.dart';
import 'package:simpad_flutter/utils/middleware.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _loginid = "";

  Future _initialogin() async {
    final String loginid = await Middleware.getParams("loginid");
    setState(() {
      _loginid = loginid;
    });
  }

  @override
  void initState() {
    _initialogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'Simpad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        // useMaterial3: true,
      ),
      home: _loginid != null ? Navigate() : Login(),
    );
  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       onGenerateRoute: MyRouter.generateRoute,
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       title: 'Simpad',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color.fromARGB(255, 255, 255, 255)),
//         // useMaterial3: true,
//       ),
//       builder: Buil,

//       home: Login(),
//     );
//   }
// }