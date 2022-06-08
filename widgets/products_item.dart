import 'package:ecommerce_app/screens/products_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(product.title),
        subtitle: Text("₦ ${product.price.toString()}"),
        trailing: IconButton(
          onPressed: //VoidCallback,
              () {
            product.toggleFavourites();
          },
          icon: Icon(
              product.isFavourite ? Icons.favorite : Icons.favorite_border),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProduuctsDetailScreen.routeName,
              arguments: product.id);
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
