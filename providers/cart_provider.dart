import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final double price;
  final int quantity;
  final String id;
  final String imgUrl;

  CartItem({
    required this.title,
    required this.price,
    required this.quantity,
    required this.id,
    required this.imgUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addItem(String productId, double price, String title, String imgUrl) {
    if (_cartItems.containsKey(productId)) {
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          title: title,
          price: price,
          quantity: 1,
          id: DateTime.now().toString(),
          imgUrl: imgUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void cartItemIncrement(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
                imgUrl: existingCartItem.imgUrl,
              ));
    }
    notifyListeners();
  }

  void cartItemDecrement(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
                imgUrl: existingCartItem.imgUrl,
              ));
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

  void removeCartItem(String productId) {
    _cartItems.removeWhere((key, value) => value.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
