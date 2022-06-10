import 'package:flutter/material.dart';

class CartItemList extends StatelessWidget {
  final String id;
  final String cartId;
  final String title;
  final double price;
  final int quantity;
  const CartItemList(
      {Key? key,
      required this.title,
      required this.price,
      required this.quantity,
      required this.id,
      required this.cartId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(title),
          subtitle: Text(price.toStringAsFixed(2)),
          trailing: Column(
            children: [
              Text("Total: ${price * quantity} $id"),
              Text(quantity.toString())
            ],
          ),
        ));
  }
}
