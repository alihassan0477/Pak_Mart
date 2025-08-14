import 'package:flutter/material.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/api/ProductApi.dart';
import 'package:pakmart/constant/buttonStyle.dart';
import 'package:pakmart/constant/screensize.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/RFQ/RFQScreen.dart';
import 'package:pakmart/service/Call.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: ProductApi().getProductsByCategory(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available.'));
            }

            final products = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 150,
                  width: Screensize(context: context).screenWidth,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 120,
                        width: 120,
                        color: Colors.white,
                        child: Image(
                          image: NetworkImage(product.images[0]),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name),
                          Text("${product.price}"),
                          Text(product.seller.name),
                          const Image(
                            height: 20,
                            image: AssetImage(
                              "lib/assets/verified-account.png",
                            ),
                          ),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () async {
                                  await Call(
                                          phoneNumber: product.seller.phoneNo)
                                      .makeCall();
                                },
                                style: outlinedButton,
                                child: const Text("Call"),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  context.navigateTo(RFQScreen(
                                    isBackButtonEnable: true,
                                  ));
                                },
                                style: rectanuglarButton.copyWith(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.green),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                ),
                                child: const Text("Get Best Price"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
