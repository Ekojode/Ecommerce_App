import 'package:flutter/material.dart';

class CartItemList extends StatelessWidget {
  final String id;
  final String cartId;
  final String title;
  final double price;
  final int quantity;
  final VoidCallback increaseCartItem;
  final VoidCallback decreaseCartItem;
  const CartItemList(
      {Key? key,
      required this.title,
      required this.price,
      required this.quantity,
      required this.id,
      required this.cartId,
      required this.increaseCartItem,
      required this.decreaseCartItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text("\$ ${price.toStringAsFixed(2)}"),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Row(
            children: [
              IconButton(
                  onPressed: decreaseCartItem, icon: const Icon(Icons.remove)),
              Text(quantity.toString()),
              IconButton(
                  onPressed: increaseCartItem, icon: const Icon(Icons.add)),
            ],
          ),
          trailing: Text((price * quantity).toStringAsFixed(2)),
        ));
  }
}
