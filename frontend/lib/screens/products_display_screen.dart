import 'package:e_commerce_application/provider/product_provider.dart';
import 'package:e_commerce_application/widgets/product-card/horizontal_product_card.dart';
import 'package:e_commerce_application/widgets/product-card/vertical_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsDisplayScreen extends StatefulWidget {
  const ProductsDisplayScreen({super.key});

  @override
  State<ProductsDisplayScreen> createState() => _ProductsDisplayScreenState();
}

class _ProductsDisplayScreenState extends State<ProductsDisplayScreen> {
  final List<String> horizontalCardCategory = [
    "smartphones",
    "laptops",
    "automotive",
    "motorcycle",
    "home-decoration",
    "furniture",
    "lighting",
  ];

  bool isHorizontalProduct(String category) {
    return horizontalCardCategory.contains(category);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }

          final products = provider.products;

          if (products.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          List<Widget> productWidgets = [];

          for (int i = 0; i < products.length; i++) {
            final product = products[i];
            final isHorizontal = isHorizontalProduct(product.category);

            if (isHorizontal) {
              productWidgets.add(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HorizontalProductCard(product: product),
                ),
              );
            } else {
              final nextIndex = i + 1;
              final canPair =
                  nextIndex < products.length &&
                  !isHorizontalProduct(products[nextIndex].category);

              if (canPair) {
                productWidgets.add(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: VerticalProductCard(product: product)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: VerticalProductCard(
                            product: products[nextIndex],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                i++;
              } else {
                productWidgets.add(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: VerticalProductCard(product: product),
                  ),
                );
              }
            }
          }
          return ListView(children: productWidgets);
        },
      ),
    );
  }
}
