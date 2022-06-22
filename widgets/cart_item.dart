import 'package:flutter/material.dart';

class NewCartItemList extends StatelessWidget {
  final String id;
  final String cartId;
  final String title;
  final double price;
  final int quantity;
  final VoidCallback increaseCartItem;
  final VoidCallback decreaseCartItem;
  final String imgUrl;
  const NewCartItemList(
      {Key? key,
      required this.title,
      required this.price,
      required this.quantity,
      required this.id,
      required this.cartId,
      required this.increaseCartItem,
      required this.decreaseCartItem,
      required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            width: screenWidth * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: screenHeight * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "Size : XL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: "\$ ",
                          style: TextStyle(color: Colors.amber),
                        ),
                        TextSpan(
                          text: " ${(price * quantity).toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: decreaseCartItem,
                        //     borderRadius: BorderRadius.circular(5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.015),
                      FittedBox(
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.015),
                      InkWell(
                        onTap: increaseCartItem,
                        //  borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                      const Spacer()
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
