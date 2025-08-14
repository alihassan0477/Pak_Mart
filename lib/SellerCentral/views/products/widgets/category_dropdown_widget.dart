import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({super.key});

  @override
  _CategoryDropDownState createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  void initState() {
    super.initState();

    context.read<BottomSheetBloc>().add(FetchCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      buildWhen: (previous, current) =>
          previous.category_id != current.category_id ||
          previous.listcategories != current.listcategories,
      builder: (context, state) {
        switch (state.listcategories.isEmpty) {
          case true:
            return const Center(child: CircularProgressIndicator());

          case false:
            return DropdownButton<String>(
              value: state.category_id.isNotEmpty ? state.category_id : null,
              hint: const Text("Select Category"),
              isExpanded: true,
              onChanged: (String? value) {
                context
                    .read<BottomSheetBloc>()
                    .add(onCategoryChanged(category_id: value!));
              },
              items: state.listcategories
                  .map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem(
                  key: Key(category.id),
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
