import 'package:e_commerce_application/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late String _productId;

  @override
  void initState() {
    super.initState();
    _productId = widget.productId;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).fetchSingleProduct(_productId);
    });
  }

  void _editProduct() {
    Navigator.pushNamed(context, '/edit-product/$_productId');
  }

  void _deleteProduct() async {
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
        await provider.deleteProduct(_productId);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Product deleted successfully')));

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete product')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context).singleProduct;

    if (product == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Image.network(
                        product.thumbnail,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Image.network(
                                product.images[index],
                                width: 60,
                                height: 60,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${product.brand} | SKU: ${product.sku}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "₹${product.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "(-${product.discountPercentage}%)",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Availability: ${product.availabilityStatus} (${product.stock} in stock)",
                        style: TextStyle(
                          color:
                              product.availabilityStatus == 'Low Stock'
                                  ? Colors.red
                                  : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("⭐ ${product.rating}/5"),
                      const SizedBox(height: 6),
                      Text("Category: ${product.category}"),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children:
                            product.tags
                                .map((tag) => Chip(label: Text(tag)))
                                .toList(),
                      ),
                      const SizedBox(height: 10),
                      Text(product.description),
                      const SizedBox(height: 5),
                      Text("Weight: ${product.weight}g"),
                      const SizedBox(height: 5),
                      Text(
                        "Dimensions: ${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm",
                      ),
                      const SizedBox(height: 5),
                      Text("Warranty: ${product.warrantyInformation}"),
                      const SizedBox(height: 5),
                      Text("Shipping: ${product.shippingInformation}"),
                      const SizedBox(height: 5),
                      Text("Return Policy: ${product.returnPolicy}"),
                      const SizedBox(height: 5),
                      Text(
                        "Minimum Order Quantity: ${product.minimumOrderQuantity}",
                      ),
                      const SizedBox(height: 10),
                      Text("Barcode: ${product.meta.barcode}"),
                      Image.network(product.meta.qrCode),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _editProduct,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _deleteProduct,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Customer Reviews",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...product.reviews.map((review) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${review.reviewerName} (⭐ ${review.rating}/5)",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(review.comment),
                  Text(
                    "Date: ${review.date}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
