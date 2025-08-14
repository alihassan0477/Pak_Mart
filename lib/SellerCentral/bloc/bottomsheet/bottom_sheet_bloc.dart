import 'package:bloc/bloc.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_events.dart';
import 'package:pakmart/SellerCentral/bloc/bottomsheet/bottom_sheet_state.dart';
import 'package:pakmart/SellerCentral/bloc/productBloc/product_bloc.dart';
import 'package:pakmart/SellerCentral/repository/product/product_repository.dart';
import 'package:pakmart/SellerCentral/utils/enums.dart';
import 'package:pakmart/service/image_picker/image_picker_service.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvents, BottomSheetState> {
  HttpProductRepo httpProductRepo = HttpProductRepo();

  BottomSheetBloc() : super(const BottomSheetState()) {
    on<onProductNameChanged>(_onProductNameChanged);
    on<onDescriptiomChanged>(_onDescriptiomChanged);
    on<onPriceChanged>(_onPriceChanged);
    on<onStockChanged>(_onStockChanged);
    on<onCategoryChanged>(_onCategoryChanged);
    on<UploadImageEvent>(_uploadImage);
    on<FetchCategoriesEvent>(_fetchCatgories);
    on<CreateProductEvents>(_createProduct);
  }

  void _onProductNameChanged(
    onProductNameChanged event,
    Emitter<BottomSheetState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onDescriptiomChanged(
    onDescriptiomChanged event,
    Emitter<BottomSheetState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onPriceChanged(onPriceChanged event, Emitter<BottomSheetState> emit) {
    emit(state.copyWith(price: event.price));
  }

  void _onStockChanged(onStockChanged event, Emitter<BottomSheetState> emit) {
    print(event.stock);
    emit(state.copyWith(stock: event.stock));
  }

  void _onCategoryChanged(
    onCategoryChanged event,
    Emitter<BottomSheetState> emit,
  ) {
    emit(state.copyWith(category_id: event.category_id));
  }

  void _uploadImage(
    UploadImageEvent event,
    Emitter<BottomSheetState> emit,
  ) async {
    emit(state.copyWith(imageUploadStatus: ImageUploadStatus.processing));
    final files = await ImagePickerService().pickMultiImage();

    if (files.isEmpty) {
      emit(state.copyWith(imageUploadStatus: ImageUploadStatus.inital));
      return;
    }

    emit(
      state.copyWith(
        listimages: files,
        imageUploadStatus: ImageUploadStatus.uploaded,
      ),
    );
  }

  void _fetchCatgories(
    FetchCategoriesEvent event,
    Emitter<BottomSheetState> emit,
  ) async {
    await httpProductRepo.fetchCategories().then((value) {
      emit(state.copyWith(listcategories: List.from(value)));
    });
  }

  void _createProduct(
    CreateProductEvents event,
    Emitter<BottomSheetState> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.inital));
    if (state.listimages.isEmpty) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
      return;
    }
    if (state.category_id.isEmpty) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
      return;
    }

    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    final listOfUrls = await ImagePickerService().uploadToCloudinary(
      state.listimages,
    );

    await httpProductRepo
        .createProduct(
          state.name,
          state.category_id,
          state.price,
          state.stock,
          state.description,
          listOfUrls,
        )
        .then((response) {
          print(response);
          emit(
            state.copyWith(
              listimages: [],
              name: "",
              category_id: "",
              price: 0,
              stock: 0,
              description: "",
              imageUploadStatus: ImageUploadStatus.inital,
              postApiStatus: PostApiStatus.completed,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(postApiStatus: PostApiStatus.error));
        });
  }
}
