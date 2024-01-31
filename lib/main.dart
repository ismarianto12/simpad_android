import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presensi_app/components/navigate.dart';
import 'package:presensi_app/pages/login.dart';
import 'package:presensi_app/route.dart';
import 'package:presensi_app/utils/middleware.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _loginid = "";

  Future<String?> _initialogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userid');
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
      home: FutureBuilder<String?>(
        future: _initialogin(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Navigate();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
