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
                  "https://cdn.britannica.com/37/231937-050-9228ECA1/Drake-rapper-2019.jpg",
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
        ],
      ),
    );
  }
}
