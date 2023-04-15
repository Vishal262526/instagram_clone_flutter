import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // creating a function to add image to the storage
  Future<String> uploadImageToStorage({
    required String uid,
    required String childName,
    required Uint8List? file,
    required bool isPost,
  }) async {
    Reference ref = _storage.ref().child(childName).child(uid);

    UploadTask upload = ref.putData(file!);
    TaskSnapshot snap = await upload;
    String url = await snap.ref.getDownloadURL();
    return url;
  }
}
