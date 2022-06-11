import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/widgets/badge.dart';
import 'package:ecommerce_app/widgets/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
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
    final cart = Provider.of<Cart>(context);
    final cartTotal = cart.quantity;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe7e4e3),
        title: const Text("Kide Commerce"),
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
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
            child: MyWidget(),
          ),
          Expanded(
            child: ProductGrid(
              showFavs: showFavs,
            ),
          ),
          const SizedBox(
            height: 60,
            child: MyWidget(),
          ),
        ],
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
