import 'package:flutter/material.dart';

import '../providers/products.dart';

class LikeStatus extends StatelessWidget {
  final Product product;
  const LikeStatus({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context);
    return IconButton(
      onPressed: () {
        product.toggleFavourites();
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
    );
  }
}
