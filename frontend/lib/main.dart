import 'package:e_commerce_application/app/app.dart';
import 'package:e_commerce_application/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
      child: const App(),
    ),
  );
}
