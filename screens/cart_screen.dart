import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    // final cartList = cart.cartItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total"),
                const Spacer(),
                Chip(
                  elevation: 10,
                  backgroundColor: Colors.blue,
                  label: Text("\$${cart.totalPrice.toStringAsFixed(2)}"),
                ),
                TextButton(onPressed: () {}, child: const Text("Order Now"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
