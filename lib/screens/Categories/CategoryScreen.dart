import 'package:flutter/material.dart';
import 'package:pakmart/Model/CategoryModel.dart';
import 'package:pakmart/api/CategoryApi.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/Products/ProductsScreen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Category>>(
          future: CategoryApi.getRootCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No categories available."));
            }

            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubCategoryScreen(
                            parentId: categories[index].id,
                          ),
                        ),
                      );
                    },
                    title: Text(categories[index].name),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.parentId});

  final String parentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder(
          future: CategoryApi.getSubCategories(
              parentId), // Replace this with your future
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              // Assuming snapshot.data contains a list

              final subCategories = snapshot.data!;
              return ListView.builder(
                itemCount:
                    subCategories.length, // Replace with snapshot.data.length
                itemBuilder: (context, index) => InkWell(
                  onTap: () => context.navigateTo(ProductsScreen(
                    category: subCategories[index].name,
                  )),
                  child: Card(
                    child: ListTile(
                      title: Text(subCategories[index].name),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
