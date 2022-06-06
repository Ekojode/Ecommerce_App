import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProduuctsDetailScreen extends StatelessWidget {
  //final String title;
  const ProduuctsDetailScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = "/productDetailScreen";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProviderProducts>(context, listen: false)
        .findById(productId);
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
            // margin: const EdgeInsets.all(8),
            height: screenHeight * 0.4,
            child: Center(
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: screenHeight * 0.6,
          decoration: BoxDecoration(
            color: Colors.purpleAccent.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loadedProduct.title),
                    Text("\$ ${loadedProduct.price}")
                  ],
                ),
              ),
              Text(
                loadedProduct.description,
                // textAlign: TextAlign.left,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.favorite)),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Add to Cart"))
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
