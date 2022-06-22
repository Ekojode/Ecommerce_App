import 'package:ecommerce_app/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  final VoidCallback deleteProduct;
  const UserProductItem({
    Key? key,
    required this.title,
    required this.imgUrl,
    required this.id,
    required this.deleteProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
        ),
        title: Text(title),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: id);
                },
                icon: const Icon(Icons.edit),
                color: Colors.black,
              ),
              IconButton(
                onPressed: deleteProduct,
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
