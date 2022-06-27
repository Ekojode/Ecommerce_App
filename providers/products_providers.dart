import 'package:ecommerce_app/models/http_exceptions.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

import './products.dart';

class ProviderProducts with ChangeNotifier {
  List<Product> _items = [
    /*   Product(
      // isFavourite: false,
      id: 'p1',
      title: 'Yellow Track Pants',
      description: 'A pretty yellow track pant',
      price: 29.99,
      imageUrl:
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmFzaGlvbiUyMG1vZGVsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'White Suit',
      description: 'Beautiful black man in a pretty white suit!',
      price: 19.99,
      imageUrl:
          'https://media.gq.com/photos/5fe121c69d8a32220e87a1c9/16:9/w_2560%2Cc_limit/story%2520dnc%2520GQ030119NYCFashion_19.jpg',
    ),
    Product(
      id: 'p5',
      title: 'African Attire',
      description:
          'Beautiful african attire made for everyone and best worn in the sahara',
      price: 19.99,
      imageUrl:
          'https://i.guim.co.uk/img/media/e193f0cc579ba041293d4616fd9929db9e2b62e8/0_889_5480_3288/master/5480.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=6d7119b1ad116474de802bbdeda1c35b',
    ),
    Product(
      id: 'p6',
      title: 'Red Suit',
      description: 'Beautiful red suit with high quality.',
      price: 49.99,
      imageUrl:
          'https://img.freepik.com/free-photo/fashion-portrait-young-elegant-woman_1328-2712.jpg?w=360',
    ),*/
  ];

  List<Product> get items {
    return _items;
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse(
        "https://kide-commerce-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      extractedData.forEach(
        (productId, productData) {
          loadedProducts.add(
            Product(
                id: productId,
                title: productData["title"],
                description: productData["description"],
                price: productData["price"],
                imageUrl: productData["imageUrl"],
                isFavourite: productData["isFavourite"]),
          );

          _items = loadedProducts;
          notifyListeners();
        },
      );
      //    print(extractedData);
    } catch (error) {
      rethrow;
    }
  }

  void newToggleFavourites(String id, Product loadedProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    _items[prodIndex] = loadedProduct;

    notifyListeners();
  }

  Future<void> addItem(Product newProduct) async {
    final url = Uri.parse(
        "https://kide-commerce-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "title": newProduct.title,
            "price": newProduct.price,
            "description": newProduct.description,
            "imageUrl": newProduct.imageUrl,
            "isFavourite": newProduct.isFavourite,
          },
        ),
      );
      final Product product = Product(
          id: jsonDecode(response.body)["name"],
          title: newProduct.title,
          description: newProduct.description,
          price: newProduct.price,
          imageUrl: newProduct.imageUrl);

      _items.add(product);
      notifyListeners();
    } catch (error) {
      rethrow;
    }

    //   print(jsonDecode(value.body));
  }

  Future<void> editItem(String id, Product editedProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    final url = Uri.parse(
        "https://kide-commerce-default-rtdb.firebaseio.com/products/$id.json");
    try {
      http.patch(
        url,
        body: jsonEncode(
          {
            "title": editedProduct.title,
            "price": editedProduct.price,
            "description": editedProduct.description,
            "imageUrl": editedProduct.imageUrl,
            "isFavourite": editedProduct.isFavourite,
          },
        ),
      );
      _items[prodIndex] = editedProduct;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    final url = Uri.parse(
        "https://kide-commerce-default-rtdb.firebaseio.com/products/$id.jsohn");

    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);

    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpExceptions("Could not delete product");
    }
    // existingProduct = null;
  }
}
