import 'package:cartify_web/views/side_bar_screens/buyers_screen.dart';
import 'package:cartify_web/views/side_bar_screens/category_screen.dart';
import 'package:cartify_web/views/side_bar_screens/orders_screen.dart';
import 'package:cartify_web/views/side_bar_screens/products_screen.dart';
import 'package:cartify_web/views/side_bar_screens/upload_banner_screen.dart';
import 'package:cartify_web/views/side_bar_screens/vendors_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();
  _screenSelector(item){
    switch(item.route) {
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
        break;
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = OrdersScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });
        break;
      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = UploadBannerScreen();
        });
        break;
      case ProductsScreen.id:
        setState(() {
          _selectedScreen = ProductsScreen();
        });
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff051247),
        title: const Text('Management',style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black,
          child: Center(
            child: Text('Cartify Admin',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
              ),
            ),
          ),
        ),
        items: [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyersScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
              title: 'Orders',
              route: OrdersScreen.id,
              icon: CupertinoIcons.cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoryScreen.id,
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            route: UploadBannerScreen.id,
            icon: CupertinoIcons.add,
          ),
          AdminMenuItem(
              title: 'Products',
              route: ProductsScreen.id,
              icon: Icons.redeem,
          ),
        ],
        selectedRoute: '',
        onSelected: (item){
          _screenSelector(item);
        },
      ),
      body: _selectedScreen,
    );
  }
}
