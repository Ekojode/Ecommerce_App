import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_list_tile.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  static const routeName = "/newOrderScreen";

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    final orderList = order.orders;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                    child: AlertDialog(
                  title: const Text("Error Occurred"),
                  content: const Text(
                      "An error occurred while loading data, this might have been due to unstable network, try reconnecting your internet"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/");
                        },
                        child: const Text("Retry"))
                  ],
                ));
              } else {
                return orderList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("You haven't placed any orders yet"),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, "/");
                                },
                                child: const Text("Return to shop"))
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
                      );
              }
            }
          }),
    );
  }
}
