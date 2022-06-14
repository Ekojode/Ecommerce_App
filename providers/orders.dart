import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final double totalAmount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.products,
      required this.totalAmount,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _order = [];

  List<OrderItem> get orders {
    return _order;
  }

  void addOrder(List<CartItem> cartProducts, double totalAmount) {
    _order.add(
      OrderItem(
        id: DateTime.now().toString(),
        products: cartProducts,
        totalAmount: totalAmount,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
