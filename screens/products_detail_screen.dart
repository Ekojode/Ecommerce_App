import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/widgets/product_suggest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/badge.dart';
import 'cart_screen.dart';

class ProduuctsDetailScreen extends StatelessWidget {
  //final String title;
  const ProduuctsDetailScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = "/productDetailScreen";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final suggestedProducts = Provider.of<ProviderProducts>(context)
        .items
        .where((element) => element.id != productId)
        .toList();

    final loadedProduct = Provider.of<ProviderProducts>(
      context,
    ).findById(productId);
    final cart = Provider.of<Cart>(context);
    final cartItem = cart.cartItems;
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    double widthSize = MediaQuery.of(context).size.width;

    final cartTotal = cart.quantity;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(loadedProduct.title,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            )),
        centerTitle: true,
        actions: [
          Badge(
              value: cartTotal.toString(),
              color: Colors.blue,
              child: IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  // margin: const EdgeInsets.all(8),
                  width: widthSize,
                  height: screenHeight * 0.4,
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loadedProduct.title,
                      style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    Text(
                      '\$ ${loadedProduct.price}',
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                height: screenHeight * 0.28,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //  shrinkWrap: true,
                  itemCount: suggestedProducts.length,
                  itemBuilder: (context, index) => ProductSuggest(
                    imgUrl: suggestedProducts[index].imageUrl,
                    productTitle: suggestedProducts[index].title,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          ProduuctsDetailScreen.routeName,
                          arguments: suggestedProducts[index].id);
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: const Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  loadedProduct.description,
                  style: const TextStyle(
                      fontSize: 13.0, color: Colors.grey, height: 1.5),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_outlined,
                          color: loadedProduct.isFavourite
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            cart.addItem(loadedProduct.id, loadedProduct.price,
                                loadedProduct.title);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 800),
                                content: Text(
                                  cartItem.containsKey(loadedProduct.id)
                                      ? "${loadedProduct.title} is already in cart"
                                      : "${loadedProduct.title} has been added to cart",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black, onPrimary: Colors.white),
                          child: const Text("Add to Cart"),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
