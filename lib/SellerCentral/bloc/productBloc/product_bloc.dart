import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/SellerCentral/bloc/productBloc/product_state.dart';
import 'package:pakmart/SellerCentral/repository/product/product_repository.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(const ProductState()) {
    on<FetchSellerProductsEvent>(_fetchSellerProductsEvent);
    on<DeleteSellerProductEvent>(_deleteSellerProduct);
  }

  void _fetchSellerProductsEvent(
    FetchSellerProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(getApiStatus: GetApiStatus.loading));

    await SellerSessionController().getSellerPrefs();

    await productRepository
        .fetchSellerProducts()
        .then((List<Product> products) {
          emit(
            state.copyWith(
              listSellerProducts: products,
              getApiStatus: GetApiStatus.completed,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(getApiStatus: GetApiStatus.error));
        });
  }

  void _deleteSellerProduct(
    DeleteSellerProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(deleteApiStatus: DeleteApiStatus.deleting));

    await Future.delayed(const Duration(seconds: 2));

    await productRepository
        .deleteSellerProductById(event.productId)
        .then((response) {
          if (response == "Product deleted successfully") {
            emit(state.copyWith(deleteApiStatus: DeleteApiStatus.successful));
          } else {
            emit(state.copyWith(deleteApiStatus: DeleteApiStatus.error));
          }
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(deleteApiStatus: DeleteApiStatus.error));
        })
        .whenComplete(() => add(FetchSellerProductsEvent()));
  }
}
