import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone_flutter/firebase/storage.dart';
import 'package:instagram_clone_flutter/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> uploadPost({
    required String uid,
    required String username,
    required Uint8List? postImage,
    required String profileImage,
    required String caption,
  }) async {
    try {
      final String postImageUrl = await Storage().uploadImageToStorage(
          uid: uid, childName: "posts", file: postImage, isPost: true);
      final String postId = const Uuid().v1();
      final Post post = Post(
        id: postId,
        uid: uid,
        username: username,
        postImage: postImageUrl,
        caption: caption,
        profileImage: profileImage,
        likes: [],
        publishedDate: DateTime.now().toString(),
      );

      // firestore.collection("posts")

      await firestore.collection("post").doc(postId).set(post.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Stream<QuerySnapshot> getAllPost() {
    return firestore.collection('post').snapshots();
  }

  static Future<bool> insertLike(String uid, String postId) async {
    try {
      final DocumentReference ref = firestore.collection('post').doc(postId);
      await ref.update({
        "likes": FieldValue.arrayUnion([uid]),
      });

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> removeLike(String uid, String postId) async {
    try {
      final DocumentReference ref = firestore.collection('post').doc(postId);
      await ref.update({
        "likes": FieldValue.arrayRemove([uid]),
      });

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // static Future<bool> addComment(String uid, String postId, String commentText) async {
  //   try {
  //     final DocumentReference ref = firestore.collection('post').doc(postId);
  //     ref.collection("comments").add({

  //     })

  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }
}