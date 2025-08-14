import 'package:flutter/material.dart';
import 'package:pakmart/Model/GlobalServices.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/Categories/CategoryScreen.dart';
import 'package:pakmart/screens/Products/ProductsScreen.dart';
import 'package:pakmart/screens/RFQ/RFQScreen.dart';
import 'package:pakmart/service/SharedPrefs.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.listOfItems});

  final List<GlobalServices> listOfItems;

  Future<bool> _checkToken() async {
    final token = await SharedPrefs.getPrefsString("token");
    return token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        bool isTokenValid = snapshot.data ?? false;

        List<GlobalServices> filteredItems = listOfItems.where((item) {
          if (item.name == "Request \n for Quotation" && !isTokenValid) {
            return false; // Skip this item if the token is not valid
          }
          return true;
        }).toList();

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    if (filteredItems[index].name == "All\nCategories") {
                      context.navigateTo(const CategoryScreen());
                    } else if (filteredItems[index].name ==
                        "Request \n for Quotation") {
                      context.navigateTo(RFQScreen());
                    } else if (filteredItems[index].name == "Machinery") {
                      context.navigateTo(
                          const ProductsScreen(category: "Machinery"));
                    } else {
                      context.navigateTo(
                          const ProductsScreen(category: "Drugs and Medicine"));
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35,
                        width: 50,
                        child: Center(
                          child: Image.asset(
                            filteredItems[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        filteredItems[index].name,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
