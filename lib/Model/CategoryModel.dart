class Category {
  Category({required this.id, required this.name});
  String id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['_id'], name: json['name']);
  }
}

// class SubCategory {
//   SubCategory({required this.sub_name});
//   String sub_name;
// }

// List<Category> allCategories = [
//   Category(
//     name: "Advertising",
//     subcategory: [
//       SubCategory(sub_name: "Advertising Products"),
//       SubCategory(sub_name: "Signs")
//     ],
//   ),
//   Category(
//     name: "Agriculture",
//     subcategory: [
//       SubCategory(sub_name: "Agriculture Fertilizers"),
//       SubCategory(sub_name: "Agriculture Pesticides")
//     ],
//   ),
//   Category(
//     name: "Baby Care",
//     subcategory: [
//       SubCategory(sub_name: "Baby Bath Supplies"),
//       SubCategory(sub_name: "Baby Bedding")
//     ],
//   )
// ];
