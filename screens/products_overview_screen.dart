import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  // List<Products> dummy = dummyProducts;
  // final _favourites = <Product>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe7e4e3),
        title: const Text("Kide Commerce"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag))
        ],
      ),
      body: const ProductGrid(),
      drawer: const Drawer(
          child: DrawerHeader(child: Text("This is a Drawer Head"))),
    );
  }
}
