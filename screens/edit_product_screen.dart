import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = "/EditProducScreen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Product"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Enter Product Name"),
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Enter Product Price"),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
            ],
          )),
        ));
  }
}
