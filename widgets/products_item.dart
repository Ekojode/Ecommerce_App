import 'package:ecommerce_app/screens/products_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/products.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    //  final cartItems = Provider.of<Cart>(context).cartItems;
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          onPressed: () {
            product.toggleFavourites();
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
        title: Text(product.title),
        subtitle: Text("₦ ${product.price.toString()}"),
        trailing: IconButton(
          onPressed: () {
            cart.addItem(product.id, product.price, product.title);
            // print(cartItems);
          },
          icon: const Icon(Icons.shopping_bag),
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
