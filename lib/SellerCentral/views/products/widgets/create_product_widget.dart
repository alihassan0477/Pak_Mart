import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';
import 'package:pakmart/SellerCentral/bloc/productBloc/product_bloc.dart';
import 'package:pakmart/SellerCentral/config/components/rounded_elevated_button.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';
import 'package:pakmart/SellerCentral/utils/utlis.dart';
import 'package:pakmart/SellerCentral/views/products/product_screen.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomSheetBloc, BottomSheetState>(
      listenWhen:
          (previous, current) =>
              previous.postApiStatus != current.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.completed) {
          Utlis.showSnackBar(context, "Product Created Successfully");
          Navigator.pop(context);
          formKey.currentState!.reset();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductSellerScreen(),
            ),
          );
        } else if (state.postApiStatus == PostApiStatus.error) {
          if (state.category_id.isEmpty || state.listimages.isEmpty) {
            Utlis.alertDialog(
              context,
              title: "Alert",
              content: "All Feilds are required",
            );
          } else {
            Utlis.alertDialog(
              context,
              title: "Alert",
              content: "Error Occurred while creating product",
            );
          }
        }
      },
      buildWhen:
          (previous, current) =>
              previous.postApiStatus != current.postApiStatus,
      builder: (context, state) {
        switch (state.postApiStatus) {
          case PostApiStatus.inital:
            return RoundedElevatedButton(
              text: "Create Product", // Fixed button text
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  Utlis.showSnackBar(
                    context,
                    "Please fill in all required fields.",
                  );
                  return;
                }
                context.read<BottomSheetBloc>().add(
                  CreateProductEvents(),
                ); // Singular event name
              },
            );
          case PostApiStatus.loading:
            return const CircularProgressIndicator();
          case PostApiStatus.completed:
            return RoundedElevatedButton(
              text: "Create Product",
              onPressed: () {
                context.read<BottomSheetBloc>().add(CreateProductEvents());
              },
            ); // Return widget after success
          case PostApiStatus.error:
            return RoundedElevatedButton(
              text: "Retry",
              onPressed: () {
                context.read<BottomSheetBloc>().add(CreateProductEvents());
              },
            ); // Handle error state
        }
      },
    );
  }
}
