import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String category;
  final bool isSelected;
  const CategorySelector(
      {Key? key, required this.category, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isSelected ? Colors.black : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black)),
      child: Text(
        category,
        textAlign: TextAlign.center,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
