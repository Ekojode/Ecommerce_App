import 'package:ecommerce_app/models/http_exceptions.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Product with ChangeNotifier {
  final String id;
  late final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  Future<void> toggleFavourites(String id, String token) async {
    final url = Uri.parse(
        "https://kide-commerce-default-rtdb.firebaseio.com/products/$id.json?auth=$token");
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final response = await http.patch(url,
        body: jsonEncode({
          "isFavourite": isFavourite,
        }));

    if (response.statusCode >= 400) {
      //  print(response.statusCode);
      isFavourite = oldStatus;

      notifyListeners();
      throw HttpExceptions("Network Error");
    }

    notifyListeners();
  }
}
