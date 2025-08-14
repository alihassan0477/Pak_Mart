part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSellerProductsEvent extends ProductEvent {}

class DeleteSellerProductEvent extends ProductEvent {
  DeleteSellerProductEvent({required this.productId});

  String productId;

  @override
  List<Object> get props => [productId];
}
