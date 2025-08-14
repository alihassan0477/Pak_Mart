import 'package:flutter/material.dart';
import 'package:pakmart/constant/screensize.dart';
import 'package:pakmart/customWidgets/productCard.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/ProductDetails/ProductDetails.dart';

class ProductsHorizontalListView extends StatelessWidget {
  final List<dynamic> ListofProducts;

  const ProductsHorizontalListView({
    super.key,
    required this.ListofProducts,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screensize(context: context).screenheight / 5.2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ListofProducts.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                context.navigateTo(ProductDetailsScreen(
                  product: ListofProducts[index],
                ));
              },
              child: ProductCard(product: ListofProducts[index]))),
    );
  }
}
