import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../screens/products_detail_screen.dart';

class NewProductItem extends StatelessWidget {
  const NewProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProduuctsDetailScreen.routeName,
                    arguments: product.id);
              },
              child: SizedBox(
                width: double.infinity,
                height: 190,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 12,
              child: IconButton(
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
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
            children: [
              const TextSpan(
                  text: "\$ ", style: TextStyle(color: Colors.amber)),
              TextSpan(
                text: product.price.toStringAsFixed(2),
              ),
            ],
          ),
        )
      ],
    );
  }
}