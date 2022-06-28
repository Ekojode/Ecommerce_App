import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/widgets/badge.dart';
import 'package:ecommerce_app/widgets/category_grid.dart';
import 'package:ecommerce_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/product_grid.dart';

class ProductsOverviewScreen extends StatefulWidget
    with WidgetsBindingObserver {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool showFavs = false;
  // bool _isInit = true;
  //bool _isLoading = false;

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<ProviderProducts>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartTotal = cart.quantity;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Badge(
              value: cartTotal.toString(),
              color: Colors.amber,
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
      body: FutureBuilder(
        future: Provider.of<ProviderProducts>(context).fetchProducts(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: AlertDialog(
                  title: const Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: const Text(
                      "Kindly login or create an account to continue"),
                  actions: [
                    TextButton(onPressed: () {}, child: const Text("Login"))
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => _refresh(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: 'Find your ',
                            ),
                            TextSpan(
                              text: 'style',
                              style: TextStyle(
                                  decorationThickness: 2,
                                  decorationColor: Colors.amber,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  decoration: TextDecoration.underline,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 60,
                      child: CategoryGrid(),
                    ),
                    Expanded(
                      child: ProductGrid(
                        showFavs: showFavs,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        }),
      ),
      drawer: const AppDrawer(),
    );
  }
}

enum FilterOption {
  favourites,
  allProducts,
}
