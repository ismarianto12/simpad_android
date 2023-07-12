import 'package:flutter/material.dart';

class ListSptpd extends StatefulWidget {
  const ListSptpd({super.key});

  @override
  State<ListSptpd> createState() => _ListSptpdState();
}

class _ListSptpdState extends State<ListSptpd>
    with SingleTickerProviderStateMixin {
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
    return const Placeholder();
  }
}
