import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';
import 'package:pakmart/SellerCentral/config/components/icon_button.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';

class UploadImageInputWidget extends StatelessWidget {
  const UploadImageInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      buildWhen: (previous, current) =>
          previous.imageUploadStatus != current.imageUploadStatus,
      builder: (context, state) {
        switch (state.imageUploadStatus) {
          case ImageUploadStatus.inital:
            return IconButtonComponent(
              text: "Upload Image",
              icon: Icons.upload,
              onPressed: () {
                context.read<BottomSheetBloc>().add(UploadImageEvent());
              },
            );

          case ImageUploadStatus.processing:
            return const CircularProgressIndicator();

          case ImageUploadStatus.uploaded:
            return GridView.builder(
              itemCount: state.listimages.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                final imagePath = state.listimages[index].path;

                return InkWell(
                  onTap: () =>
                      context.read<BottomSheetBloc>().add(UploadImageEvent()),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    height: 100,
                    width: 100,
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
