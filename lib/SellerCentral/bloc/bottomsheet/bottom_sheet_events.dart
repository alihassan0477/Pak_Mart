import 'package:equatable/equatable.dart';

abstract class BottomSheetEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class onProductNameChanged extends BottomSheetEvents {
  onProductNameChanged({required this.name});

  String name;
  @override
  List<Object> get props => [name];
}

class onCategoryChanged extends BottomSheetEvents {
  onCategoryChanged({required this.category_id});

  String category_id;

  @override
  List<Object> get props => [category_id];
}

class onPriceChanged extends BottomSheetEvents {
  onPriceChanged({required this.price});

  int price;

  @override
  List<Object> get props => [price];
}

class onStockChanged extends BottomSheetEvents {
  onStockChanged({required this.stock});

  int stock;

  @override
  List<Object> get props => [stock];
}

class onDescriptiomChanged extends BottomSheetEvents {
  onDescriptiomChanged({required this.description});

  String description;

  @override
  List<Object> get props => [description];
}

class UploadImageEvent extends BottomSheetEvents {}

class FetchCategoriesEvent extends BottomSheetEvents {}

class CreateProductEvents extends BottomSheetEvents {}
