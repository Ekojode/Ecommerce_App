import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './products_item.dart';
import '../providers/products_providers.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProductItem(
              imgUrl: products[index].imageUrl,
              title: products[index].title,
              price: products[index].price,
              isTapped: products[index].isFavourite,
              /*     onPressed: () {
                dummyProducts[index].isFavourite
                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${dummyProducts[index].title} has been removed from favourites"),
                      ))
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            " ${dummyProducts[index].title} has been added to favourites")));
                setState(() {
                  print(_favourites.length + 1);
                  dummyProducts[index].isFavourite =
                      !dummyProducts[index].isFavourite;
                  if (dummyProducts[index].isFavourite == false) {
                    _favourites.remove(dummyProducts[index]);
                  } else {
                    _favourites.add(dummyProducts[index]);
                  }
                });
              },*/
              id: products[index].id,
            );
          }),
    );
  }
}
