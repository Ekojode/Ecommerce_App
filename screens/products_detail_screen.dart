import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/widgets/product_suggest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

import '../widgets/badge.dart';
import 'cart_screen.dart';

class ProduuctsDetailScreen extends StatelessWidget {
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
    suggestedProducts.shuffle();
    final newSuggestedProducts = suggestedProducts.sublist(0, 3);

    final loadedProduct =
        Provider.of<ProviderProducts>(context).findById(productId);

    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    double widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          loadedProduct.title,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (BuildContext context, value, Widget? child) => Badge(
              value: value.quantity.toString(),
              color: Colors.amber,
              child: IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
            ),
            /* child: 
          ),*/
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  width: widthSize,
                  height: screenHeight * 0.45,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      loadedProduct.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loadedProduct.title,
                      style: const TextStyle(
                          fontSize: 20.0,
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
                height: screenHeight * 0.025,
              ),
              SizedBox(
                height: screenHeight * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newSuggestedProducts.length,
                  itemBuilder: (context, index) => ProductSuggest(
                    imgUrl: newSuggestedProducts[index].imageUrl,
                    productTitle: newSuggestedProducts[index].title,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          ProduuctsDetailScreen.routeName,
                          arguments: newSuggestedProducts[index].id);
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
              SizedBox(
                height: screenHeight * 0.01,
              ),
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
                      //  flex: 3,
                      child: Consumer<Cart>(
                        builder: (context, value, child) => ElevatedButton(
                          onPressed: () {
                            value.addItem(loadedProduct.id, loadedProduct.price,
                                loadedProduct.title, loadedProduct.imageUrl);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                action: SnackBarAction(
                                  label: "UNDO",
                                  onPressed: () {
                                    value.removeItem(loadedProduct.id);
                                  },
                                ),
                                duration: const Duration(milliseconds: 800),
                                content: Text(
                                  value.cartItems.containsKey(loadedProduct.id)
                                      ? "${loadedProduct.title} is already in cart"
                                      : "${loadedProduct.title} has been added to cart",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            fixedSize:
                                Size(widthSize * 0.9, screenHeight * 0.08),
                          ),
                          child: const Text("Add to Cart"),
                        ),
                      ),
                    )
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
