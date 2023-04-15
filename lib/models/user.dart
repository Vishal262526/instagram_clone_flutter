import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String username;
  final String email;
  final String profileUrl;
  final List followers;
  final List following;
  final String bio;

  const User(
      {required this.uid,
      required this.name,
      required this.username,
      required this.email,
      required this.profileUrl,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "username": username,
        "email": email,
        "profile_url": profileUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static User fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data() as Map<String, dynamic>;
    return User(
      uid: data['uid'],
      name: data['name'],
      username: data['username'],
      email: data['email'],
      profileUrl: data['profile_url'],
      bio: data['bio'],
      followers: data['followers'],
      following: data['following'],
    );
  }
}
