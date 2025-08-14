import 'package:equatable/equatable.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';

class ProductState extends Equatable {
  const ProductState(
      {this.listSellerProducts = const [],
      this.getApiStatus = GetApiStatus.loading,
      this.deleteApiStatus = DeleteApiStatus.inital});

  final List<Product> listSellerProducts;
  final GetApiStatus getApiStatus;
  final DeleteApiStatus deleteApiStatus;

  ProductState copyWith(
      {List<Product>? listSellerProducts,
      GetApiStatus? getApiStatus,
      DeleteApiStatus? deleteApiStatus}) {
    return ProductState(
        listSellerProducts: listSellerProducts ?? this.listSellerProducts,
        getApiStatus: getApiStatus ?? this.getApiStatus,
        deleteApiStatus: deleteApiStatus ?? this.deleteApiStatus);
  }

  @override
  List<Object> get props => [listSellerProducts, getApiStatus, deleteApiStatus];
}
