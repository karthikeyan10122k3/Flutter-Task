import 'package:e_commerce_application/model/product/edit_product_model.dart';
import 'package:e_commerce_application/model/product/product_model.dart';
import 'package:e_commerce_application/provider/product_provider.dart';
import 'package:e_commerce_application/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  const EditProductScreen({super.key, required this.productId});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late String _productId;
  bool _showFetchButton = false;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _discountPercentageController =
      TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _availabilityStatusController =
      TextEditingController();
  final TextEditingController _minimumOrderQuantityController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _productId = widget.productId;
    if (_productId != '-1') {
      _loadProduct(_productId);
    } else {
      _showFetchButton = true;
    }
  }

  void _loadProduct(String id) async {
    try {
      Product product = await ProductService().getProduct(id);
      setState(() {
        _idController.text = product.id;
        _titleController.text = product.title;
        _priceController.text = product.price.toString();
        _categoryController.text = product.category;
        _discountPercentageController.text =
            product.discountPercentage.toString();
        _stockController.text = product.stock.toString();
        _availabilityStatusController.text = product.availabilityStatus;
        _minimumOrderQuantityController.text =
            product.minimumOrderQuantity.toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product not found")));
    }
  }

  void _fetchProduct() {
    String id = _idController.text;
    if (id.isNotEmpty) {
      _loadProduct(id);
    }
  }

  void _submit() async {
    EditProductModel updatedProduct = EditProductModel(
      title: _titleController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      category: _categoryController.text,
      discountPercentage:
          double.tryParse(_discountPercentageController.text) ?? 0,
      stock: int.tryParse(_stockController.text) ?? 0,
      availabilityStatus: _availabilityStatusController.text,
      minimumOrderQuantity:
          int.tryParse(_minimumOrderQuantityController.text) ?? 0,
    );

    try {
      await Provider.of<ProductProvider>(
        context,
        listen: false,
      ).editProduct(_idController.text, updatedProduct);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product updated successfully")));

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to update product")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 69, 6, 241),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_showFetchButton) ...[
              Row(
                children: [
                  SizedBox(
                    width:
                        MediaQuery.of(context).size.width *
                        0.6, // 60% of screen width
                    child: _buildTextField(_idController, 'Product Id'),
                  ),

                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: _fetchProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellowAccent,
                    ),
                    child: const Text(
                      "Fetch Product",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              _buildTextField(_idController, 'Product Id'),
            ],
            _buildTextField(_titleController, 'Title'),
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
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                "Save Changes",
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
