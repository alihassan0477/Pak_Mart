import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/category_dropdown_widget.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/create_product_widget.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/price_input_widget.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/product_description_input_widget.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/product_name_input_widget.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/stock_input_widget.dart';
import 'package:pakmart/SellerCentral/views/products/widgets/upload_image_input_widget.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  late BottomSheetBloc _bottomSheetBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bottomSheetBloc = BottomSheetBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bottomSheetBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return _bottomSheetBloc;
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Information"),
                    subtitle: Text("This bottom sheet has a fixed height."),
                  ),
                  const ProductNameInputWidget(),
                  const ProductDescriptionInput(),
                  const PriceInputWidget(),
                  const StockInputWidget(),
                  const CategoryDropDown(),
                  const UploadImageInputWidget(),
                  CreateProduct(formKey: _formKey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
