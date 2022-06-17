import 'package:ecommerce_app/providers/category.dart';
import 'package:ecommerce_app/widgets/category_selector.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> categoryList = [
      Category(category: "All", isSelected: true),
      Category(category: "Men", isSelected: false),
      Category(category: "Women", isSelected: false),
      Category(category: "EyeWear", isSelected: false),
      Category(category: "Winter", isSelected: false),
      Category(category: "Summer", isSelected: false),
    ];
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categoryList.length,
      itemBuilder: (context, index) => CategorySelector(
        category: categoryList[index].category,
        isSelected: categoryList[index].isSelected,
      ),
    );
  }
}
