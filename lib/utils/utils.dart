import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickimage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  final XFile? pickedImage = await _imagePicker.pickImage(source: source);

  if (pickedImage != null) {
    return await pickedImage.readAsBytes();
  }
  return null;
}


