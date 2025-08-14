import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';

class StockInputWidget extends StatelessWidget {
  const StockInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Stock',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a stock quantity';
            }
            final stock = int.tryParse(value);
            if (stock == null || stock < 0) {
              return 'Please enter a valid stock quantity';
            }
            return null;
          },
          onChanged: (value) {
            context
                .read<BottomSheetBloc>()
                .add(onStockChanged(stock: int.tryParse(value) ?? 0));
          },
        );
      },
    );
  }
}
