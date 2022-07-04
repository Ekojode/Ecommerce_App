import 'package:ecommerce_app/providers/orders.dart';

import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/screens/auth_screen.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/edit_product_screen.dart';

import 'package:ecommerce_app/screens/order_screen.dart';
import 'package:ecommerce_app/screens/products_detail_screen.dart';
import 'package:ecommerce_app/screens/products_overview_screen.dart';
import 'package:ecommerce_app/screens/user_products_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProviderProducts>(
            create: (_) => ProviderProducts("", [], ""),
            update: (context, auth, previousProducts) => ProviderProducts(
                auth.token, previousProducts!.items, auth.userId)),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders([], "", ""),
            update: (context, auth, previousOrders) =>
                Orders(previousOrders!.orders, auth.userId, auth.token)),
      ],
      builder: (context, child) {
        return Consumer<Auth>(
          builder: (BuildContext context, auth, Widget? child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xfff9f9f9),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xfff9f9f9),
                  foregroundColor: Colors.black),
            ),
            home:

                //   print(auth),
                auth.isAuth
                    ? const ProductsOverviewScreen()
                    : const AuthScreen(),
            routes: {
              ProduuctsDetailScreen.routeName: (context) =>
                  const ProduuctsDetailScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrderScreen.routeName: (context) => const OrderScreen(),
              UserProductsScreen.routeName: ((context) =>
                  const UserProductsScreen()),
              EditProductScreen.routeName: ((context) =>
                  const EditProductScreen()),
            },
          ),
          //  child:
        );
      },
    );
  }
}
