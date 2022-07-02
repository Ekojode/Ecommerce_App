import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class LikeStatus extends StatelessWidget {
  final Product product;
  const LikeStatus({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context);
    return Consumer<Auth>(
      builder: (context, value, child) => IconButton(
        onPressed: () async {
          try {
            product.toggleFavourites(product.id, value.token);
          } catch (error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Error Occurred")));
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 800),
              content: Text(
                product.isFavourite
                    ? "${product.title} added to favourites"
                    : "${product.title} removed from favourites",
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        icon: Icon(
          product.isFavourite ? Icons.favorite : Icons.favorite_outline,
          color: product.isFavourite ? Colors.red : null,
        ),
      ),
    );
  }
}
