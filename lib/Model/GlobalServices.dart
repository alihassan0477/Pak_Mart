class GlobalServices {
  GlobalServices(this.name, this.imageUrl);
  String imageUrl;
  String name;
}

List<GlobalServices> globalServices = [
  GlobalServices("All\nCategories", "lib/assets/category.png"),
  GlobalServices("Request \n for Quotation", "lib/assets/target.png"),
  GlobalServices("Machinery", "lib/assets/crane.png"),
  GlobalServices("Drugs and \n Medicine", "lib/assets/pills.png"),
];
