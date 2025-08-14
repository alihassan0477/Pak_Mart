import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';

class ProductNameInputWidget extends StatelessWidget {
  const ProductNameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Product Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter a product name'
              : null,
          onChanged: (value) {
            context
                .read<BottomSheetBloc>()
                .add(onProductNameChanged(name: value));
          },
        );
      },
    );
  }
}
