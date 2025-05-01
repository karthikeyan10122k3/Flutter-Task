import 'package:e_commerce_application/screens/home_screen.dart';
import 'package:e_commerce_application/screens/product_details_screen.dart';
import 'package:e_commerce_application/screens/add_product_screen.dart';
import 'package:e_commerce_application/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // colorScheme: ColorScheme.dark(),
        // scaffoldBackgroundColor: const Color.fromARGB(192, 107, 44, 243),

        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(color: Colors.red),
        //   bodyMedium: TextStyle(color: Colors.red),
        //   titleLarge: TextStyle(color: Colors.red),
        //   // Add more styles if needed
        // ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add-product': (context) => const AddProductScreen(),
      },
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments[0] == 'product-details') {
          final String id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(productId: id),
          );
        }
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments[0] == 'edit-product') {
          final id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (context) => EditProductScreen(productId: id),
          );
        }
        return null;
      },
    );
  }
}
