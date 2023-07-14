import 'package:flutter/material.dart';
import '../models/menuModel.dart';

class Menu extends StatelessWidget {
  final List<menuModel> menuItems;

  Menu({required this.menuItems});

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = 4;
    final int rowCount = (menuItems.length / crossAxisCount).ceil();

    return GridView.count(
      crossAxisCount: crossAxisCount,
      padding: EdgeInsets.all(10),
      mainAxisSpacing: 26,
      crossAxisSpacing: 0,
      children: menuItems.map((item) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, item.route!);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item.colors,
                  borderRadius: BorderRadiusDirectional.circular(160),
                ),
                child: Icon(item.icon, size: 25, color: Colors.white),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        item.title!,
                        style: const TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 9.5),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        item.subtitle!,
                        style: const TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 9.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
