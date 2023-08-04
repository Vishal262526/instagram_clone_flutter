import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String uid;
  final String username;
  final String postImage;
  final String caption;
  final String profileImage;
  final List likes;
  final String publishedDate;

  Post({
    required this.id,
    required this.uid,
    required this.username,
    required this.postImage,
    required this.caption,
    required this.profileImage,
    required this.likes,
    required this.publishedDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'uid': uid,
      "username": username,
      "post_image": postImage,
      "caption": caption,
      "profile_image": profileImage,
      "likes": likes,
      "published_date": publishedDate,
    };
  }

  factory Post.fromDocumentSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return Post(
      id: data['id'],
      uid: data['uid'],
      username: data['username'],
      postImage: data['post_image'],
      caption: data['caption'],
      profileImage: data['profile_image'],
      likes: data['likes'],
      publishedDate: data['published_date'],
    );
  }
}
