import 'package:ecommerce_app/widgets/drawer.dart';
import 'package:ecommerce_app/widgets/user_product_utem.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/products_providers.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  static const routeName = "/user_products";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProviderProducts>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) {
            return UserProductItem(
              title: productsData.items[index].title,
              imgUrl: productsData.items[index].imageUrl,
            );
          }),
    );
  }
}
