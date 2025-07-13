import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text('Management'),
      ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Vendors',
            route: '',
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: '',
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(title: 'Orders', route: '', icon: CupertinoIcons.cart),
          AdminMenuItem(
            title: 'Categories',
            route: '',
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            route: '',
            icon: CupertinoIcons.add,
          ),
          AdminMenuItem(title: 'Products', route: '', icon: Icons.redeem),
        ],
        selectedRoute: '',
      ),
      body: Text('Dashboard'),
    );
  }
}
