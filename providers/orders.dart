import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

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

  Future<void> addOrder(List<CartItem> cartProducts, double totalAmount) async {
    final url = Uri.parse(
        "https://kide-commerce-default-rtdb.firebaseio.com/orders.json");
    final time = DateTime.now();

    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "totalAmount": totalAmount,
          "time": time.toIso8601String(),
          "cartProducts": cartProducts.toString()
          /*        .map((e) => {
                    {
                      "title": e.title,
                      "price": e.price,
                      "quantity": e.quantity,
                      "id": e.id,
                      "imgUrl": e.imgUrl,
                    }
                  })
              .toList()*/
          //    .toString()
        },
      ),
    );
    print(response.statusCode);
    _order.add(
      OrderItem(
        id: jsonDecode(response.body)["name"],
        products: cartProducts,
        totalAmount: totalAmount,
        dateTime: time,
      ),
    );
    notifyListeners();
    /*catch (error) {
      rethrow;
    }*/
  }
}
