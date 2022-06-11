import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    final cartList = cart.cartItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final item = cartList.keys.toList()[index];
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(item),
                  onDismissed: (direction) {
                    cart.removeCartItem(cartList.values.toList()[index].id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 800),
                        content: Text(
                            "${cartList.values.toList()[index].title} has been removed from Cart"),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete_forever,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  child: CartItemList(
                    title: cartList.values.toList()[index].title,
                    price: cartList.values.toList()[index].price,
                    quantity: cartList.values.toList()[index].quantity,
                    id: cartList.values.toList()[index].id,
                    cartId: cartList.keys.toList()[index],
                  ),
                );
              },
            ),
          ),
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
