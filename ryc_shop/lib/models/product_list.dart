import 'package:flutter/material.dart';
import 'package:ryc_shop/data/dummy_data.dart';
import 'package:ryc_shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  bool _showFavorite = false;

  List<Product> get items {
    if (_showFavorite) {
      return _items.where((elem) => elem.isFavorite).toList();
    }

    return [..._items];
  }

  void showFavoriteOnly() {
    _showFavorite = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorite = false;
    notifyListeners();
  }
}
