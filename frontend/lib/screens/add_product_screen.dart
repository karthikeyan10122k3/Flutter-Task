import 'package:e_commerce_application/model/product/dimensions_model.dart';
import 'package:e_commerce_application/model/product/meta_model.dart';
import 'package:e_commerce_application/model/product/product_model.dart';
import 'package:e_commerce_application/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _discountPercentageController = TextEditingController();
  final _stockController = TextEditingController();
  final _availabilityStatusController = TextEditingController();
  final _minimumOrderQuantityController = TextEditingController();
  final _thumbnailController = TextEditingController();

  Future<void> _submit() async {
    if (_titleController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Title and Price are required')));
      return;
    }

    final newProduct = Product(
      title: _titleController.text,
      description: _descriptionController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      discountPercentage:
          double.tryParse(_discountPercentageController.text) ?? 0.0,
      rating: 0.0,
      stock: int.tryParse(_stockController.text) ?? 0,
      category: _categoryController.text,
      tags: [_categoryController.text],
      brand: 'Default Brand',
      sku: 'SKU${DateTime.now().millisecondsSinceEpoch}',
      weight: 1,
      dimensions: Dimensions(height: 10, width: 10, depth: 10),
      warrantyInformation: 'No warranty',
      shippingInformation: 'Standard shipping',
      availabilityStatus: _availabilityStatusController.text,
      reviews: [],
      returnPolicy: '7 days return',
      minimumOrderQuantity:
          int.tryParse(_minimumOrderQuantityController.text) ?? 1,
      meta: Meta(
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        barcode: "9164035109868",
        qrCode: "https://assets.dummyjson.com/public/qr-code.png",
      ),
      images: [
        "https://cdn.dummyjson.com/products/images/fragrances/Calvin%20Klein%20CK%20One/1.png",
        "https://cdn.dummyjson.com/products/images/fragrances/Calvin%20Klein%20CK%20One/2.png",
        "https://cdn.dummyjson.com/products/images/fragrances/Calvin%20Klein%20CK%20One/3.png",
      ],
      thumbnail: _thumbnailController.text,
    );

    try {
      await Provider.of<ProductProvider>(
        context,
        listen: false,
      ).addProduct(newProduct);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Product added successfully')));

      _titleController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _categoryController.clear();
      _discountPercentageController.clear();
      _stockController.clear();
      _availabilityStatusController.clear();
      _minimumOrderQuantityController.clear();
      _thumbnailController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add product: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 69, 6, 241),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_titleController, 'Title'),
            _buildTextField(_descriptionController, 'Description'),
            _buildTextField(_priceController, 'Price'),
            _buildTextField(_categoryController, 'Category'),
            _buildTextField(_discountPercentageController, 'Discount %'),
            _buildTextField(_stockController, 'Stock'),
            _buildTextField(
              _availabilityStatusController,
              'Availability Status',
            ),
            _buildTextField(
              _minimumOrderQuantityController,
              'Minimum Order Quantity',
            ),
            _buildTextField(_thumbnailController, 'Thumbnail Link'),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                "Add Product",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
