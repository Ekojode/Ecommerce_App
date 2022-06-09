import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/screens/products_detail_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
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
        Provider<ProviderProducts>(create: (context) => ProviderProducts()),
        Provider<Cart>(create: (_) => Cart()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xfff9f9f9)),
          home: const ProductsOverviewScreen(),
          routes: {
            ProduuctsDetailScreen.routeName: (context) =>
                const ProduuctsDetailScreen()
          },
        );
      },
    );
  }
}
