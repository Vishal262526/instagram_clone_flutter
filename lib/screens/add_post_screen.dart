import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/models/user.dart' as model;
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool _isLoading = false;
  Uint8List? imageFile;
  late final model.User? user;
  final TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    user = Provider.of<UserProvider>(context, listen: false).getUser;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _captionController.dispose();
    super.dispose();
  }

  void uploadPost(Uint8List postImage) async {
    try {
      setState(() {
        _isLoading = true;
      });
      bool postUploadStatus = await FirestoreMethods.uploadPost(
        uid: user!.uid,
        username: user!.username,
        postImage: postImage,
        profileImage: user!.profileUrl!,
        caption: _captionController.text,
      );

      if (postUploadStatus) {
        showSnackbar("Posted");
        imageFile = null;
        _isLoading = false;
        setState(() {});
      } else {
        showSnackbar("Something went wrong");
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      showSnackbar(e.toString());
      _isLoading = false;
      setState(() {});
    }
  }

  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          text,
        ),
      ),
    );
  }

  void _selectImage() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a Post"),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                imageFile = await pickimage(ImageSource.gallery);
                setState(() {});
              },
              padding: const EdgeInsets.all(20.0),
              child: Text("Gallery"),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                imageFile = await pickimage(ImageSource.camera);
                setState(() {});
              },
              padding: const EdgeInsets.all(20.0),
              child: Text("Camera"),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              padding: const EdgeInsets.all(20.0),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageFile == null
        ? Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: _selectImage,
              icon: const Icon(
                Icons.upload,
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: mobileBackgroundColor,
              actions: [
                TextButton(
                  onPressed: () => uploadPost(imageFile!),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    imageFile = null;
                  });
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: const Text("Post to"),
            ),
            body: Column(
              children: [
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: LinearProgressIndicator(
                      color: primaryColor,
                      backgroundColor: secondaryColor,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: user!.profileUrl != "no"
                          ? Image.network(user!.profileUrl)
                          : Image.asset("assets/user.png"),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _captionController,
                          decoration: const InputDecoration(
                            hintText: "Write a Caption",
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(imageFile!),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
