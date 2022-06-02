//import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/widgets/products_item.dart';
import 'package:flutter/material.dart';

import '../lists/product_list.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  // List<Products> dummy = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kide Commerce"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag))
        ],
      ),
      body: GridView.builder(
          itemCount: dummyProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProductItem(
                imgUrl: dummyProducts[index].imageUrl,
                title: dummyProducts[index].title,
                price: dummyProducts[index].price);
          }),
    );
  }
}
