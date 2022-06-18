import 'package:ecommerce_app/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_providers.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = "/EditProducScreen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Product _editedProduct = Product(
    id: "",
    title: "",
    description: "",
    price: 0,
    imageUrl: "",
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrlFocus);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrlFocus);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  bool _isInit = true;
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imgUrl": "",
    "id": ""
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments as String;
      if (id != "") {
        final product =
            Provider.of<ProviderProducts>(context, listen: false).findById(id);
        _editedProduct = product;
        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          "imgUrl": ""
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrlFocus() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_editedProduct.id != "") {
        final editProduct =
            Provider.of<ProviderProducts>(context, listen: false);
        editProduct.editItem(_editedProduct.id, _editedProduct);
      } else {
        final newProduct =
            Provider.of<ProviderProducts>(context, listen: false);
        newProduct.addItem(_editedProduct);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Enter Product Name"),
                ),
                initialValue: _initValues["title"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a product title";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value!,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Enter Product Price"),
                ),
                initialValue: _initValues["price"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a price.";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid Price";
                  }
                  if (double.parse(value) <= 0) {
                    return "Please enter a price greater than zero";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Enter Product Description"),
                ),
                initialValue: _initValues["description"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter product description";
                  }
                  if (value.length < 10) {
                    return "Please enter a description with at least 10 characters";
                  }
                  return null;
                },
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value!,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 8.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    child: SizedBox(
                      child: _imageUrlController.text.isEmpty
                          ? const Center(
                              child: Text(
                                "Enter an Image URL",
                                textAlign: TextAlign.center,
                              ),
                            )
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text("Enter Image Url")),
                      initialValue: _initValues["imgUrl"],
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter Product Image Url";
                        }
                        if (!val.startsWith("http") &&
                            !val.startsWith("https")) {
                          return "Please enter a valid Url";
                        }
                        if (!val.endsWith("jpg") &&
                            !val.endsWith("png") &&
                            !val.endsWith("jpeg") &&
                            !val.endsWith("webp")) {
                          return "Please enter a valid Url";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value!,
                            isFavourite: _editedProduct.isFavourite);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
