import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // Private constructor
  ImagePickerService._();

  // static instance (singleton)
  static final ImagePickerService instance = ImagePickerService._();

  // create factory constructor

  factory ImagePickerService() {
    return instance;
  }

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  Future<XFile?> pickImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    return image;
  }

  Future<List<XFile>> pickMultiImage() async {
    final images = await _picker.pickMultiImage();

    return images;
  }

  Future<List<String>> uploadToCloudinary(List<XFile> images) async {
    final cloudinary =
        CloudinaryPublic('dkmep29ua', 'flutter_uploads', cache: false);

    List<String> uploadedImagesUrl = [];
    for (XFile image in images) {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image));

      uploadedImagesUrl.add(response.url);

      print(uploadedImagesUrl[0]);
    }

    return uploadedImagesUrl;
  }
}
