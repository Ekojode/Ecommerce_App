import 'package:flutter/material.dart';

class ProductSuggest extends StatelessWidget {
  final String imgUrl;
  final String productTitle;
  const ProductSuggest(
      {Key? key, required this.imgUrl, required this.productTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    double widthSize = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.25,
      width: widthSize * 0.4,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        SizedBox(
            height: screenHeight * 0.22,
            child: Image.network(imgUrl, fit: BoxFit.cover)),
        Text(
          productTitle,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        )
      ]),
    );
  }
}