import 'package:flutter/material.dart';
import '../models/menuModel.dart';

List<menuModel> menuModels = [
  menuModel(
    title: 'Pegembalian',
    subtitle: 'Penitipan',
    icon: Icons.keyboard_return_rounded,
    colors: Color.fromARGB(255, 14, 142, 105),
    route: '/pengembalian',
  ),
  menuModel(
    title: 'Laporan',
    subtitle: 'Penitipan',
    icon: Icons.report,
    colors: Color.fromARGB(255, 13, 189, 98),
    route: '/penitipanlist',
  ),
  menuModel(
    title: 'Data',
    subtitle: 'Peminjaman',
    icon: Icons.save_as_outlined,
    colors: Colors.orange[400],
    route: '/peminjamanform',
  ),
  menuModel(
    title: 'Listdata',
    subtitle: 'Peminjaman',
    icon: Icons.verified_user_sharp,
    colors: Colors.orange[500],
    route: '/peminjamanlist',
  ),
  menuModel(
    title: 'Pengembalian',
    subtitle: 'Barang Pinjam',
    icon: Icons.settings,
    colors: const Color.fromARGB(255, 25, 203, 31),
    route: '/laporan_peminjaman',
  ),
  menuModel(
    title: 'Pengembalian',
    subtitle: 'Peminjaman',
    icon: Icons.money_off_csred_rounded,
    colors: const Color.fromARGB(255, 48, 191, 52),
    route: '/retunpinjam',
  ),
  // tambahkan item lainnya
];
