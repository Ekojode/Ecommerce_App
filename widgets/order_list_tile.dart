import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';

import '../providers/cart_provider.dart';

class OrderExpansionTile extends StatelessWidget {
  final String orderId;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;
  const OrderExpansionTile({
    Key? key,
    required this.orderId,
    required this.amount,
    required this.dateTime,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ExpandablePanel(
              header: Text(
                "\$ ${amount.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              collapsed: Text(DateFormat.yMMMEd().format(dateTime)),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Your order Summary;"),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (ctx, i) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: FittedBox(
                              child: Text(products[i].price.toStringAsFixed(2)),
                            ),
                          ),
                          title: Text(products[i].title),
                          subtitle: Text(
                              "Price: ${(products[i].price * products[i].quantity).toStringAsFixed(2)}"),
                          trailing: Text(
                              "Qty: ${(products[i].quantity).toStringAsFixed(2)}"),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ));
  }
}
