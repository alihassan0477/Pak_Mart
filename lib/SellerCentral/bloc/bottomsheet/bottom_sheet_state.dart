import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pakmart/Model/CategoryModel.dart';
import 'package:pakmart/Model/ProductModel.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';

class BottomSheetState extends Equatable {
  const BottomSheetState({
    this.name = "",
    this.category_id = "",
    this.price = 0,
    this.stock = 0,
    this.seller_id = "",
    this.description = "",
    this.imageUploadStatus = ImageUploadStatus.inital,
    this.listimages = const [],
    this.listcategories = const [],
    this.postApiStatus = PostApiStatus.inital,
  });
  final String name;
  final String category_id;
  final int price;
  final int stock;
  final String description;
  final String seller_id;

  final ImageUploadStatus imageUploadStatus;
  final List<XFile> listimages;
  final List<Category> listcategories;
  final PostApiStatus postApiStatus;

  BottomSheetState copyWith(
      {String? name,
      String? category_id,
      int? price,
      int? stock,
      String? description,
      String? seller_id,
      ImageUploadStatus? imageUploadStatus,
      List<XFile>? listimages,
      List<Category>? listcategories,
      List<Product>? listOfSellerProducts,
      PostApiStatus? postApiStatus}) {
    return BottomSheetState(
      name: name ?? this.name,
      category_id: category_id ?? this.category_id,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      seller_id: seller_id ?? this.seller_id,
      description: description ?? this.description,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      listimages: listimages ?? this.listimages,
      listcategories: listcategories ?? this.listcategories,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [
        name,
        category_id,
        price,
        stock,
        description,
        seller_id,
        imageUploadStatus,
        listimages,
        listcategories,
        postApiStatus
      ];
}
