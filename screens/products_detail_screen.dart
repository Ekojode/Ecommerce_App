import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProduuctsDetailScreen extends StatelessWidget {
  //final String title;
  const ProduuctsDetailScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = "/productDetailScreen";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<ProviderProducts>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        centerTitle: true,
      ),
      body:
          Center(child: Text(loadedProduct.title + loadedProduct.description)),
    );
  }
}
