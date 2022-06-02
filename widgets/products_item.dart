import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String imgUrl;
  final String title;
  final double price;
  const ProductItem(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

//final Color buttonColor = Colors.red;

class _ProductItemState extends State<ProductItem> {
  bool _isTapped = false;
  @override
  //bool _isTapped = false;
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
          //s  backgroundColor: Colors.red,
          trailing: IconButton(
        onPressed: () {
          // Icons.abc;
          setState(() {
            _isTapped = !_isTapped;
            // buttonColor = Colors.accents;
          });
        },
        icon: Icon(
          Icons.favorite,
          color: _isTapped ? Colors.red : Colors.amber,
        ),
      )),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(widget.title),
        subtitle: Text("₦ ${widget.price.toString()}"),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        child: Image.network(
          widget.imgUrl,
          fit: BoxFit.cover,
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
