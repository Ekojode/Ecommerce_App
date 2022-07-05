import 'package:ecommerce_app/widgets/like_status.dart';
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
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 8,
                right: 12,
                child: LikeStatus(
                  product: product,
                )),
          ],
        ),
        const SizedBox(height: 10),
        FittedBox(
          child: Text(
            product.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
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
