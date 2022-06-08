import 'package:ecommerce_app/providers/products_providers.dart';
import 'package:ecommerce_app/widgets/product_suggest.dart';
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
    final suggestedProducts = Provider.of<ProviderProducts>(context)
        .items
        .where((element) => element.id != productId)
        .toList();

    final loadedProduct = Provider.of<ProviderProducts>(context, listen: false)
        .findById(productId);
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(loadedProduct.title,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            )),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  // margin: const EdgeInsets.all(8),
                  width: widthSize,
                  height: screenHeight * 0.4,
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loadedProduct.title,
                        style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black)),
                    Text('\$ ${loadedProduct.price}',
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                height: screenHeight * 0.3,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //  shrinkWrap: true,
                    itemCount: suggestedProducts.length,
                    itemBuilder: (context, index) => ProductSuggest(
                        imgUrl: suggestedProducts[index].imageUrl,
                        productTitle: suggestedProducts[index].title)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: const Text('Description',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              const SizedBox(height: 15.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(loadedProduct.description,
                    style: const TextStyle(
                        fontSize: 13.0, color: Colors.grey, height: 1.5)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_outlined),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black, onPrimary: Colors.white),
                          child: const Text("Add to Cart"),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


/* Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.favorite)),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Add to Cart"))
                  ],
                )
              ],
            ),
          )*/