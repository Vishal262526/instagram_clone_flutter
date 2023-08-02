import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //     alignment: Alignment.center,
    //     child: IconButton(
    //       onPressed: () {},
    //       icon: Icon(
    //         Icons.upload,
    //       ),
    //     ));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: mobileBackgroundColor,
        actions: [
          TextButton(
            onPressed: () {},
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
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text("Post to"),
      ),
    );
  }
}
