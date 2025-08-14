import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/api/ProductApi.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/ProductDetails/ProductDetails.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> products = [];
  List<Product> searchProducts = [];
  bool isLoading = true;
  // bool isInitial = true; // Flag to track the initial state
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final loadProducts = await ProductApi().get_all_products();
    products = loadProducts;
    setState(() {
      isLoading = false;
      searchProducts =
          products.take(10).toList(); // Show first 4 products initially
    });
  }

  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 300), () {
      print(value);
      search(value);
    });

    // print(value);

    // search(value);
  }

  void search(String value) {
    setState(() {
      if (value.isNotEmpty) {
        // isInitial = false; // Switch to search mode
        searchProducts = products.where((product) {
          final lowerCaseValue = value.toLowerCase();
          return product.name.toLowerCase().contains(lowerCaseValue) ||
              product.category.toLowerCase().contains(lowerCaseValue);
        }).toList();
      } else {
        // isInitial = true; // Back to initial view
        searchProducts = products.take(10).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildSearchBar(),
                  Expanded(child: _buildProductList()),
                ],
              ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        onChanged: onSearchChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    if (searchProducts.isEmpty) {
      return const Center(child: Text('No products found.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: searchProducts.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          style: ListTileStyle.drawer,
          titleAlignment: ListTileTitleAlignment.titleHeight,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.green)),
          contentPadding: const EdgeInsets.all(10),
          tileColor: Colors.grey.shade100,
          onTap: () => context
              .navigateTo(ProductDetailsScreen(product: searchProducts[index])),
          title: Text(searchProducts[index].name),
        ),
      ),
    );
  }
}
