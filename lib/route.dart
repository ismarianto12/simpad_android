import 'package:flutter/material.dart';
import 'package:simpad_flutter/pages/Profile.dart';
import 'package:simpad_flutter/pages/dashboard.dart';
import 'package:simpad_flutter/pages/laporSptpd.dart';
import 'package:simpad_flutter/pages/listSptpd.dart';
import 'package:simpad_flutter/pages/login.dart';

import 'components/navigate.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => Navigate());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/lapor_sptpd':
        return MaterialPageRoute(builder: (_) => LaporSptpd());
      case '/list_sptpd':
        return MaterialPageRoute(builder: (_) => ListSptpd());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Halaman ini masih dalam pengembangan ${settings.name}',
                  style: const TextStyle(fontSize: 20.0),
                ),
                MaterialButton(
                  color: Colors.red, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (_) => const Navigate());
                    Navigator.push(_, route);
                  },
                  child: const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      'Back To Home',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}
