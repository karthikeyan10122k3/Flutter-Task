import 'package:e_commerce_application/screens/add_product_screen.dart';
import 'package:e_commerce_application/screens/edit_product_screen.dart';
import 'package:e_commerce_application/screens/products_display_screen.dart';
import 'package:e_commerce_application/widgets/layout/custom_app_bar.dart';
import 'package:e_commerce_application/widgets/layout/custom_bottom_navigation_bar.dart';
import 'package:e_commerce_application/widgets/layout/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    ProductsDisplayScreen(),
    AddProductScreen(),
    EditProductScreen(productId: '-1'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _changeIndex,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
