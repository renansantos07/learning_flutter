import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ryc_shop/models/cart.dart';
import 'package:ryc_shop/models/cart_item.dart';
import 'package:ryc_shop/models/order.dart';
import 'package:ryc_shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];
  final String _token;
  final String _userId;

  OrderList([this._token = '', this._userId = '', this._items = const []]);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await get(
      Uri.parse('${Constants.orderBaseUrl}/$_userId.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    data.forEach((orderId, orderData) {
      final products = (orderData['products'] as List<dynamic>).map((item) {
        return CartItem(
          id: item['id'],
          productId: item['productId'],
          name: item['name'],
          quantity: item['quantity'],
          price: item['price'],
        );
      }).toList();

      items.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: products,
        ),
      );
    });

    _items = items.reversed.toList();
    notifyListeners();
    return;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await post(
      Uri.parse('${Constants.orderBaseUrl}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map(
                (cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}
