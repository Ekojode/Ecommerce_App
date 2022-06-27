import 'package:ecommerce_app/screens/edit_product_screen.dart';
import 'package:ecommerce_app/widgets/drawer.dart';
import 'package:ecommerce_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/products_providers.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  static const routeName = "/user_products";

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<ProviderProducts>(context, listen: false).fetchProducts();
  }

  Future<void> deleteProduct() async {}

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
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName,
                  arguments: "");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (context, index) {
              return UserProductItem(
                title: productsData.items[index].title,
                imgUrl: productsData.items[index].imageUrl,
                id: productsData.items[index].id,
                deleteProduct: () async {
                  try {
                    await productsData.deleteItem(productsData.items[index].id);
                  } catch (error) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "An error occured",
                              style: TextStyle(color: Colors.red),
                            ),
                            content: const Text(
                                "Something went wrong, Please check your internet connection."),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OKAY",
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          );
                        });
                  }
                },
              );
            }),
      ),
    );
  }
}
