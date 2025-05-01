import 'package:e_commerce_application/model/product/edit_product_model.dart';
import 'package:e_commerce_application/model/product/product_model.dart';
import 'package:e_commerce_application/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();

  List<Product> _products = [];
  Product? _singleProduct;
  bool _isLoading = false;
  String _errorMessage = '';

  List<Product> get products => _products;
  Product? get singleProduct => _singleProduct;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch all products
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.getAllProducts();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load products: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Fetch Product by ID
  Future<void> fetchSingleProduct(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _singleProduct = await _productService.getProduct(id);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load product: $e';
      _singleProduct = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Edit product
  Future<void> editProduct(String id, EditProductModel updatedModel) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedProduct = await _productService.editProduct(
        id,
        updatedModel,
      );

      final index = _products.indexWhere((product) => product.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
      }

      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to update product: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add product
  Future<void> addProduct(Product newProduct) async {
    _isLoading = true;
    notifyListeners();

    try {
      final addedProduct = await _productService.addProduct(newProduct);
      _products.add(addedProduct);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to add product: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Delete product
  Future<void> deleteProduct(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _productService.deleteProduct(id);
      _products.removeWhere((product) => product.id == id);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to delete product: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
