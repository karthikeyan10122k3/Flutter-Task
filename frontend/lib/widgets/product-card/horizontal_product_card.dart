import 'package:e_commerce_application/model/product/product_model.dart';
import 'package:e_commerce_application/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalProductCard extends StatelessWidget {
  final Product product;
  const HorizontalProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    void deleteProduct() async {
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Confirm Deletion'),
              content: Text('Are you sure you want to delete this product?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Delete'),
                ),
              ],
            ),
      );

      if (shouldDelete == true) {
        final provider = Provider.of<ProductProvider>(context, listen: false);
        try {
          await provider.deleteProduct(product.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product deleted successfully')),
          );
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to delete product')));
        }
      }
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            margin: const EdgeInsets.all(8),
            child: Image.network(product.thumbnail, fit: BoxFit.cover),
          ),
          // Info Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "₹${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "M.R.P: ₹${(product.price / (1 - product.discountPercentage / 100)).toStringAsFixed(2)} "
                    "(${product.discountPercentage}% off)",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    "Rating: ⭐ ${product.rating} / 5 (${product.reviews.length} reviews)",
                  ),
                  Text(
                    product.availabilityStatus == "Low Stock"
                        ? "Only ${product.stock} left in stock"
                        : "In stock",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          product.availabilityStatus == "Low Stock"
                              ? Colors.red
                              : Colors.green,
                    ),
                  ),
                  Text(
                    "🚚 ${product.shippingInformation}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton.icon(
                          onPressed: deleteProduct,
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit-product/${product.id}',
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
