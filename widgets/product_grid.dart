import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './products_item.dart';
import '../providers/products_providers.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  const ProductGrid({
    Key? key,
    required this.showFavs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProviderProducts>(context);
    final products =
        showFavs ? productsData.favouriteItems : productsData.items;
    return Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
          //  scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ChangeNotifierProvider.value(
              // create: (context) => products[index],
              value: products[index],
              child: const ProductItem(),
            );
          }),
    );
  }
}
