import 'package:flutter/material.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/Model/SellerModel.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final String name;
  final String category;
  final int price;
  final int stock;
  final String description;
  final Seller seller;
  final List<String> images;
  final List<Specifications> specifications;

  const ProductDetailsBottomSheet({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.description,
    required this.seller,
    required this.images,
    required this.specifications,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Carousel
              SizedBox(
                height: 300,
                child: PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) => Image.network(
                    images[index],
                  ),
                ),
              ),
              // Product Name and Category
              Text(
                name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Category: $category',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(),

              // Price and Stock Information
              Row(
                children: [
                  Text(
                    '\$$price',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Spacer(),
                  Text(
                    'In Stock: $stock',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const Divider(),

              // Description
              const Text(
                'Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(),

              // Seller Information
              Text(
                'Seller: ${seller.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Rating: ',
                style: TextStyle(fontSize: 16),
              ),
              const Divider(),

              // Specifications
              const Text(
                'Specifications:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: specifications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      specifications[index].key,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(specifications[index].value),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
