import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';

class ProductDescriptionInput extends StatelessWidget {
  const ProductDescriptionInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Product Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter a product description'
              : null,
          onChanged: (value) {
            context
                .read<BottomSheetBloc>()
                .add(onDescriptiomChanged(description: value));
          },
        );
      },
    );
  }
}
