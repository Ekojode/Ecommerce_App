import 'package:flutter/cupertino.dart';

class CartItem {
  final String title;
  final double price;
  final int quantity;
  final String id;

  CartItem({
    required this.title,
    required this.price,
    required this.quantity,
    required this.id,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addItem(String productId, double price, String title) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
            id: existingCartItem.id),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          title: title,
          price: price,
          quantity: 1,
          id: DateTime.now().toString(),
        ),
      );
    }
    notifyListeners();
  }

  int get quantity {
    return _cartItems.length;
  }

  double get totalPrice {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}
