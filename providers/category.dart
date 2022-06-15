class Category {
  final String category;
  final bool isSelected;

  Category({
    required this.category,
    required this.isSelected,
  });

  final List<Category> _categoryList = [
    Category(category: "All", isSelected: true),
    Category(category: "Men", isSelected: false),
    Category(category: "Women", isSelected: false),
    Category(category: "EyeWear", isSelected: false),
    Category(category: "Winter", isSelected: false),
    Category(category: "Summer", isSelected: false),
  ];

  List<Category> get categoryList {
    return _categoryList;
  }
}
