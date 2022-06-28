import 'package:provider/provider.dart';
import '../providers/orders.dart';

import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';
import 'new_orders_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = "/cartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    final cartList = cart.cartItems;

    final order = Provider.of<Orders>(context, listen: false);
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: const Color(0xfff5f4f4),
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
                        child: NewCartItemList(
                          title: cartList.values.toList()[index].title,
                          price: cartList.values.toList()[index].price,
                          quantity: cartList.values.toList()[index].quantity,
                          id: cartList.values.toList()[index].id,
                          cartId: cartList.keys.toList()[index],
                          decreaseCartItem: () {
                            if (cartList.values.toList()[index].quantity >= 2) {
                              cart.cartItemDecrement(
                                  cartList.keys.toList()[index]);
                            } else {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                  content: Text(
                                    "Product quantity cannot be less than one",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
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
                Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "Subtotal",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                          children: [
                            const TextSpan(
                              text: "\$ ",
                              style: TextStyle(color: Colors.amber),
                            ),
                            TextSpan(
                              text: " ${cart.subTotalPrice.toStringAsFixed(2)}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Shipping",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      trailing: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                          children: [
                            TextSpan(
                              text: "\$ ",
                              style: TextStyle(color: Colors.amber),
                            ),
                            TextSpan(
                              text: "10.0",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 10,
                      thickness: 2,
                    ),
                    ListTile(
                      title: const Text(
                        "Total",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                          children: [
                            const TextSpan(
                              text: "\$ ",
                              style: TextStyle(color: Colors.amber),
                            ),
                            TextSpan(
                              text: " ${cart.totalPrice.toStringAsFixed(2)}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        //     Navigator.pushNamed(context, OrderScreen.routeName);
                        try {
                          await order.addOrder(
                              cartList.values.toList(), cart.totalPrice);
                          //     cart.clearCart();

                          setState(() {
                            _isLoading = false;
                          });
                          cart.clearCart();
                        } catch (error) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("An error occured"),
                                  content: const Text(
                                      "Something went wrong, Order couldn't be completed at the moment Please try again!."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "OKAY",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                );
                              });
                        } finally {
                          Navigator.pushNamed(
                              context, NewOrderScreen.routeName);
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: screenHeight * 0.075,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                              child: const Center(
                                  child: Text(
                                "Order Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                            ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
