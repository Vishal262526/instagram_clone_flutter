import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Storage {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  // creating a function to add image to the storage
  Future<String> uploadImageToStorage({
    required String uid,
    required String childName,
    required Uint8List? file,
    required bool isPost,
  }) async {
    Reference ref = storage.ref().child(childName).child(uid);

    if (isPost) {
      final String postId = Uuid().v1();
      ref = ref.child(postId);
    }

    UploadTask upload = ref.putData(file!);
    TaskSnapshot snap = await upload;
    String url = await snap.ref.getDownloadURL();
    return url;
  }
}
