import 'package:ecommerce_app/providers/orders.dart';

import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/screens/auth_screen.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/edit_product_screen.dart';
import 'package:ecommerce_app/screens/new_orders_screen.dart';
import 'package:ecommerce_app/screens/order_screen.dart';
import 'package:ecommerce_app/screens/products_detail_screen.dart';
import 'package:ecommerce_app/screens/products_overview_screen.dart';
import 'package:ecommerce_app/screens/user_products_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import './screens/new_orders_screen.dart';
import 'providers/products.dart';

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
            create: (_) => ProviderProducts("", []),
            update: (context, auth, previousProducts) =>
                ProviderProducts(auth.token, previousProducts!.items
                    //  previousProducts == null ? [] : previousProducts.items,
                    )),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        ChangeNotifierProvider<Orders>(create: (_) => Orders()),
      ],
      builder: (context, child) {
        return Consumer<Auth>(
          builder: (context, auth, child) => MaterialApp(
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
              NewOrderScreen.routeName: (context) => const NewOrderScreen(),
            },
          ),
          //   child:
        );
      },
    );
  }
}
