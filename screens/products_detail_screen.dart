import 'package:flutter/material.dart';

class ProduuctsDetailScreen extends StatelessWidget {
  //final String title;
  const ProduuctsDetailScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = "/productDetailScreen";

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs),
        centerTitle: true,
      ),
    );
  }
}
