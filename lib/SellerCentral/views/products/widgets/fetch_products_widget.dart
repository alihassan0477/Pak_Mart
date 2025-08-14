import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/productBloc/product_bloc.dart';
import 'package:pakmart/SellerCentral/bloc/productBloc/product_state.dart';
import 'package:pakmart/SellerCentral/config/components/container_with_image.dart';
import 'package:pakmart/SellerCentral/config/components/product_details_buttomSheet_container.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';
import 'package:pakmart/SellerCentral/utils/utlis.dart';

class FetchProducts extends StatelessWidget {
  const FetchProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen:
          (previous, current) =>
              previous.deleteApiStatus != current.deleteApiStatus,
      listener: (context, state) {
        if (state.deleteApiStatus == DeleteApiStatus.successful) {
          Utlis.showSnackBar(context, "Product Deleted Successfully");
        } else if (state.deleteApiStatus == DeleteApiStatus.error) {
          Utlis.showSnackBar(context, "Error Occurred while deleting product");
        }
      },
      buildWhen:
          (previous, current) =>
              previous.listSellerProducts != current.listSellerProducts ||
              previous.getApiStatus != current.getApiStatus ||
              previous.deleteApiStatus != current.deleteApiStatus,
      builder: (context, state) {
        switch (state.getApiStatus) {
          case GetApiStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case GetApiStatus.completed:
            if (state.deleteApiStatus == DeleteApiStatus.deleting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: state.listSellerProducts.length,
              itemBuilder: (context, index) {
                final product = state.listSellerProducts[index];
                return ContainerWithImage(
                  ondeletePressed: () {
                    context.read<ProductBloc>().add(
                      DeleteSellerProductEvent(productId: product.id!),
                    );
                  },
                  onPressed: () {
                    Utlis.showButtomSheet(
                      context,
                      ProductDetailsBottomSheet(
                        name: product.name,
                        category: product.category,
                        description: product.description,
                        images: product.images,
                        price: product.price,
                        seller: product.seller,
                        specifications: product.specifications,
                        stock: product.stock,
                      ),
                    );
                  },
                  title: product.name,
                  image_url: product.images[0],
                );
              },
            );

          case GetApiStatus.error:
            return const Center(child: Text("No products found"));
        }
      },
    );
  }
}
