import 'package:flutter/material.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/constant/textStyles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white.withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image(
              image: NetworkImage(product.images[0]),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            child: Text(
              product.name,
              style: boldWith16px,
            ),
          )
        ],
      ),
    );
  }
}
