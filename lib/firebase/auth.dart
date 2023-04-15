import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_flutter/firebase/storage.dart';
import 'package:instagram_clone_flutter/models/user.dart' as model;

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Storage _storage = Storage();

  // For login an existing user

  Future<model.User> getUserDetail() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot snap =
        await firestore.collection('users').doc(currentUser.uid).get();
    final data = model.User.fromDocumentSnapshot(snap);    
    print("Data in Auth...................");
    return model.User.fromDocumentSnapshot(snap);
  }

  Future<Map> signupUser({
    required String email,
    required String password,
    required String fullName,
    required String bio,
    required String username,
    Uint8List? profile,
  }) async {
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          fullName.isNotEmpty &&
          username.isNotEmpty) {
        final UserCredential userCred = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCred.user);

        // Upload image and get the url if the image is selected by the user
        final profileUrl = profile != null
            ? await _storage.uploadImageToStorage(
                uid: userCred.user!.uid,
                childName: 'profile',
                file: profile,
                isPost: false,
              )
            : 'no';

        model.User userModel = model.User(
          uid: userCred.user!.uid,
          name: fullName,
          username: username,
          email: email,
          profileUrl: profileUrl,
          bio: bio,
          followers: [],
          following: [],
        );

        // Add User to our Database
        await firestore.collection('users').doc(userCred.user!.uid).set(
              userModel.toJson(),
            );
        return {"success": true, "msg": "User Successfully SignUp"};
      } else {
        return {"success": false, "err": "All Fields are Required"};
      }
    } on FirebaseAuthException catch (e) {
      return {"success": false, "err": e.message.toString()};
    } catch (e) {
      return {"success": false, "err": e.toString()};
    }
  }

  // For creating a new user
  Future<Map> loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return {"success": true};
    } on FirebaseAuthException catch (err) {
      return {"success": false, "err": err.message};
    } catch (err) {
      return {"success": false, "err": err};
    }
  }
}
