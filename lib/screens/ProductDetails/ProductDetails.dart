import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/Model/SellerModel.dart';
import 'package:pakmart/constant/buttonStyle.dart';
import 'package:pakmart/constant/textStyles.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/Chats/IndividualChat.dart';
import 'package:pakmart/screens/RFQ/RFQScreen.dart';
import 'package:pakmart/screens/Reviews/ReviewsScreen.dart';
import 'package:pakmart/service/Call.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    print(product.images);
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Call(phoneNumber: product.seller.phoneNo).makeCall();
                },
                style: rectanuglarButton.copyWith(
                  foregroundColor: WidgetStateProperty.all(Colors.green),
                ),
                child: const Text("Call"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.navigateTo(RFQScreen(isBackButtonEnable: true));
                },
                style: rectanuglarButton.copyWith(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                child: const Text("Get Best Price"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.navigateTo(
                    IndividualChatScreen(
                      receiverId: product.seller.id!,
                      sellerName: product.seller.name,
                    ),
                  );
                },
                style: rectanuglarButton.copyWith(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  foregroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 100, 22, 22),
                  ),
                ),
                child: const Text("chat"),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image(
              image: NetworkImage(product.images[0]),
              height: 300,
              fit: BoxFit.cover,
            ),
            ProductInformation(product: product),
          ],
        ),
      ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  ProductInformation({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(product.name, style: boldWith18px),
              const SizedBox(height: 8),
              Text(
                "PKR ${product.price} / unit",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(),
              const SizedBox(height: 8),
              const Text("Description", style: boldWith16px),
              const SizedBox(height: 4),
              Text(product.description),
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                "Specifications",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),

              // Uncomment the Table if needed
              // Table(
              //   border: TableBorder.all(),
              //   columnWidths: const {
              //     0: FlexColumnWidth(1),
              //     1: FlexColumnWidth(1),
              //   },
              //   children: [
              //     TableRow(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[0].key),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[0].value),
              //         ),
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[1].key ?? ""),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[1].value ?? ""),
              //         ),
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[2].key ?? ""),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[2].value ?? ""),
              //         ),
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[3].key ?? ""),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8),
              //           child: Text(product.specifications[3].value ?? ""),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              const Divider(),

              const SizedBox(height: 20),

              SellerInfo(seller: product.seller),

              const SizedBox(height: 20),

              ListTile(
                leading: const Text("Reviews", style: boldWith18px),
                trailing: const Icon(Icons.arrow_forward),
                onTap:
                    () => context.navigateTo(
                      ReviewsScreen(product_id: product.id!),
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SellerInfo extends StatelessWidget {
  SellerInfo({super.key, required this.seller});

  Seller seller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 100,
          width: 100,
          child: Icon(Icons.person_2, size: 50),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(seller.name, style: lessdarkWith16px),
              Text(
                seller.storeName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const RatingBar.readOnly(
                size: 20,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                initialRating: 4,
                maxRating: 5,
              ),
              const Icon(Icons.check_box),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
      ],
    );
  }
}
