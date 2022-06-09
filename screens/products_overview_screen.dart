import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool showFavs = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe7e4e3),
        title: const Text("Kide Commerce"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              onSelected: (FilterOption value) {
                setState(() {
                  if (value == FilterOption.favourites) {
                    showFavs = true;
                  } else {
                    showFavs = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: FilterOption.favourites,
                      child: Text("Favourites"),
                    ),
                    const PopupMenuItem(
                      value: FilterOption.allProducts,
                      child: Text("All Products"),
                    ),
                  ]),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag))
        ],
      ),
      body: ProductGrid(
        showFavs: showFavs,
      ),
      drawer: const Drawer(
          child: DrawerHeader(child: Text("This is a Drawer Head"))),
    );
  }
}

enum FilterOption {
  favourites,
  allProducts,
}
