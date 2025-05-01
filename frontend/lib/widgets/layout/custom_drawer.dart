import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red[200],
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Flutter Task Karthikeyan Menu')),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add-product');
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: const Text('Edit Product'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/edit-product/-1');
            },
          ),
        ],
      ),
    );
  }
}
