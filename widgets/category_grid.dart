import 'package:ecommerce_app/providers/category.dart';
import 'package:ecommerce_app/widgets/category_selector.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Category> categoryList = [
      Category(category: "Men"),
      Category(category: "Women", isSelected: true),
      Category(category: "Men"),
      Category(category: "Women", isSelected: true),
      Category(category: "Men"),
      Category(category: "Women", isSelected: true),
      Category(category: "Men"),
      Category(category: "Women", isSelected: true),
    ];
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categoryList.length,
      itemBuilder: (context, index) => CategorySelector(
          category: categoryList[index].category,
          isSelected: categoryList[index].isSelected),
    );
  }
}
