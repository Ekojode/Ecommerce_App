import 'package:ecommerce_app/widgets/drawer.dart';
import 'package:ecommerce_app/widgets/order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const routeName = "/OrderScreen";

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    final orderList = order.orders;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Orders"),
        centerTitle: true,
      ),
      body: orderList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You haven't placed any orders yet"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/");
                      },
                      child: const Text("Return to Shop"))
                ],
              ),
            )
          : ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (ctx, i) => OrderExpansionTile(
                orderId: orderList[i].id,
                amount: orderList[i].totalAmount,
                dateTime: orderList[i].dateTime,
                products: orderList[i].products,
              ),
            ),
    );
  }
}
