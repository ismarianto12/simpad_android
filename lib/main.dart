import 'package:flutter/material.dart';
import 'package:simpad_flutter/pages/login.dart';
import 'package:simpad_flutter/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: 'Simpad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        // useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
