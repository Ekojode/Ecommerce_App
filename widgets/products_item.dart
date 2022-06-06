//import 'package:ecommerce_app/models/products.dart';
import 'package:ecommerce_app/screens/products_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final double price;
  final bool isTapped;
  final String id;
  //final VoidCallback onPressed;
  const ProductItem(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.price,
      required this.isTapped,
      //  required this.onPressed,
      required this.id})
      : super(key: key);

/*  @override
  State<ProductItem> createState() => _ProductItemState();
}

//final Color buttonColor = Colors.red;

class _ProductItemState extends State<ProductItem> {
  // bool _isTapped = false;

  // final _saved = <Products>[];
  @override*/
  //bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GridTile(
      /*  header: GridTileBar(
          //s  backgroundColor: Colors.red,
          trailing: IconButton(
      //  onPressed: onPressed,
        icon: Icon(
          Icons.favorite,
          color: isTapped ? Colors.red : Colors.white,
        ),
      )),*/
      footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(title),
          subtitle: Text("₦ ${price.toString()}"),
          trailing: const Icon(
            Icons.favorite_outline,
          )),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProduuctsDetailScreen.routeName,
              arguments: id);
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          child: Image.network(
            imgUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    /*Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  imgUrl,
                  fit: BoxFit.contain,
                  //  height: 300,
                ),
                Positioned(
                  top: 5,
                  left: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.amberAccent,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 3,
            ),
            Text("₦ $price")
          ],
        ));*/
  }
}
