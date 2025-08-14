import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pakmart/SellerCentral/bloc/productBloc/product_bloc.dart';
import 'package:pakmart/SellerCentral/utils/utlis.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/bottom_sheet.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/fetch_products_widget.dart';
import 'package:pakmart/main.dart';

class ProductSellerScreen extends StatefulWidget {
  const ProductSellerScreen({super.key});

  @override
  State<ProductSellerScreen> createState() => _ProductSellerScreenState();
}

class _ProductSellerScreenState extends State<ProductSellerScreen> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();

    _productBloc = ProductBloc(productRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Utlis.showButtomSheet(context, const BottomSheetContent());
        },
        backgroundColor: Colors.green,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Icon(Icons.add, size: 30.0, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BlocProvider(
        create: (context) => _productBloc..add(FetchSellerProductsEvent()),
        child: const Center(child: FetchProducts()),
      ),
    );
  }
}
