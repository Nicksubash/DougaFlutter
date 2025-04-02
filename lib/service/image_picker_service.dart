import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickMedia(String source) async {
    try {
      final XFile? file = source == 'gallery'
          ? await _picker.pickMedia()
          : await _picker.pickImage(source: ImageSource.camera);

      return file != null ? File(file.path) : null;
    } catch (e) {
      print('Error picking media: $e');
      return null;
    }
  }
}