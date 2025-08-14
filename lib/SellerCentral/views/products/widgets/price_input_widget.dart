import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';

class PriceInputWidget extends StatelessWidget {
  const PriceInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'price',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a price';
            }
            final price = int.tryParse(value);
            if (price == null || price <= 0) {
              return 'Please enter a valid price';
            }
            return null;
          },
          onChanged: (value) {
            context
                .read<BottomSheetBloc>()
                .add(onPriceChanged(price: int.tryParse(value) ?? 0));
          },
        );
      },
    );
  }
}
