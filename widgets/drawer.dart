import 'package:ecommerce_app/screens/new_orders_screen.dart';
import 'package:ecommerce_app/screens/order_screen.dart';
import 'package:ecommerce_app/screens/user_products_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  "https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blte0aac921c3798f1e/61a633990039cb54c5e25acb/Lionel_Messi_(10).jpg?auto=webp&fit=crop&format=jpg&height=800&quality=60&width=1200",
                ),
              ),
              accountName: Text("Ekojode Oma-Victor"),
              accountEmail: Text("ekojodeoma@gmail.com")),
          ListTile(
            leading: const Icon(
              Icons.shop,
              color: Colors.amber,
            ),
            title: const Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.payment,
              color: Colors.blueAccent,
            ),
            title: const Text("Orders"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
              color: Colors.pinkAccent,
            ),
            title: const Text("Manage Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
              color: Colors.pinkAccent,
            ),
            title: const Text("New Order Screen"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(NewOrderScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
