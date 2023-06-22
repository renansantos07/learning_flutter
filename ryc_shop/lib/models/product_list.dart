import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ryc_shop/data/dummy_data.dart';
import 'package:ryc_shop/exceptions/http_exception.dart';
import 'package:ryc_shop/models/product.dart';
import 'package:ryc_shop/utils/constants.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];
  bool _showFavorite = false;

  int get itemsCount {
    return _items.length;
  }

  List<Product> get items {
    if (_showFavorite) {
      return _items.where((elem) => elem.isFavorite).toList();
    }

    return [..._items];
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json'),
    );

    if (response.body == 'null') {
      return;
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  void showFavoriteOnly() {
    _showFavorite = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorite = false;
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
