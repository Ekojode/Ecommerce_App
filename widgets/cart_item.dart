import 'package:flutter/material.dart';

class CartItemList extends StatelessWidget {
  final String id;
  final String cartId;
  final String title;
  final double price;
  final int quantity;
  final String imgUrl;
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
      required this.decreaseCartItem,
      required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    double widthSize = MediaQuery.of(context).size.width;
    return Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: SizedBox(
            height: screenHeight * 0.2,
            width: widthSize * 0.35,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imgUrl,
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
