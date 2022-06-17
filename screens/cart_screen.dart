import 'package:ecommerce_app/screens/order_screen.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    final cartList = cart.cartItems;

    final order = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: cartList.values.toList().isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Your Cart is Currently empty"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Return to Shop"))
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      final item = cartList.values.toList()[index].id;
                      return Dismissible(
                        confirmDismiss: ((direction) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Delete Cart Item?"),
                                  content: const Text(
                                      "Are you sure you want to delete this Item from the cart?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text("NO")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text("YES"))
                                  ],
                                );
                              });
                        }),
                        direction: DismissDirection.endToStart,
                        key: Key(item),
                        onDismissed: (direction) {
                          cart.removeCartItem(
                              cartList.values.toList()[index].id);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: "UNDO",
                                onPressed: () {
                                  cart.addItem(
                                      cartList.keys.toList()[index],
                                      cartList.values.toList()[index].price,
                                      cartList.values.toList()[index].title,
                                      cartList.values.toList()[index].imgUrl);
                                },
                              ),
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
                          decreaseCartItem: () {
                            cart.cartItemDecrement(
                                cartList.keys.toList()[index]);
                          },
                          increaseCartItem: () {
                            cart.cartItemIncrement(
                                cartList.keys.toList()[index]);
                          },
                          imgUrl: cartList.values.toList()[index].imgUrl,
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
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, OrderScreen.routeName);
                            order.addOrder(
                                cartList.values.toList(), cart.totalPrice);
                            cart.clearCart();
                          },
                          child: const Text("Order Now"))
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
