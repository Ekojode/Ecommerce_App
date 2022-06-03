//import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/widgets/products_item.dart';
import 'package:flutter/material.dart';

import '../lists/product_list.dart';
import '../models/products.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  // List<Products> dummy = dummyProducts;
  final _favourites = <Products>[];
  void _show() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Product added to Favourites!"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe7e4e3),
        title: const Text("Kide Commerce"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: dummyProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductItem(
                imgUrl: dummyProducts[index].imageUrl,
                title: dummyProducts[index].title,
                price: dummyProducts[index].price,
                isTapped: dummyProducts[index].isFavourite,
                onPressed: () {
                  dummyProducts[index].isFavourite
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          content: Text("Product removed from favourites"),
                        ))
                      : ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Product added to favourites")));
                  setState(() {
                    print(_favourites.length);
                    dummyProducts[index].isFavourite =
                        !dummyProducts[index].isFavourite;
                    if (dummyProducts[index].isFavourite == false) {
                      _favourites.remove(dummyProducts[index]);
                    } else {
                      _favourites.add(dummyProducts[index]);
                    }
                  });
                },
              );
            }),
      ),
      drawer: Drawer(
        child: _favourites.isEmpty
            ? const Text("Nothing is saved yet")
            : ListView.builder(
                itemCount: _favourites.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_favourites[index].title),
                  );
                },
              ),
      ),
    );
  }
}
