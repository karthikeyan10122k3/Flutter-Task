import 'dart:convert';
import 'package:e_commerce_application/model/product/edit_product_model.dart';
import 'package:e_commerce_application/model/product/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final _baseUrl = "http://localhost:8080/api/product";

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products: ${response.body}");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Product> getProduct(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/$id"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final productJson = data['product'];
        return Product.fromJson(productJson);
      } else {
        final data = jsonDecode(response.body);
        throw Exception("Failed to Get product: ${data['error']}");
      }
    } catch (error) {
      throw Exception("Exception in getProduct: $error");
    }
  }

  Future<Product> addProduct(Product newProduct) async {
    final productJson = newProduct.toJson();

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: jsonEncode(productJson),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final product = Product.fromJson(data['product']);
        return product;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception("Failed to add product: ${errorData['error']}");
      }
    } catch (error) {
      throw Exception("Exception in addProduct: $error");
    }
  }

  Future<Product> editProduct(
    String id,
    EditProductModel editingProduct,
  ) async {
    final product = editingProduct.toJson();
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/$id"),
        body: jsonEncode(product),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final productJson = data['product'];
        return Product.fromJson(productJson);
      } else {
        final data = jsonDecode(response.body);
        throw Exception("Failed to update product: ${data['error']}");
      }
    } catch (error) {
      throw Exception("Exception in editProduct: $error");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse("$_baseUrl/$id"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Deleted Product: ${data['product']}");
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception("Failed to delete product: ${errorData['error']}");
      }
    } catch (error) {
      throw Exception("Exception in deleteProduct: $error");
    }
  }
}
