import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/components/comment_card.dart';
import 'package:instagram_clone_flutter/components/post_card.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.postId});
  final String postId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  late final User _user;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _comments;

  @override
  void initState() {
    // TODO: implement initState
    _user = Provider.of<UserProvider>(context, listen: false).getUser!;
    _comments = FirestoreMethods.getComments(postId: widget.postId);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: _comments,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                final snap = snapshot.data.docs[index];
                return CommentCard(
                  name: snap['name'],
                  datePublished: snap['datePublished'].toString(),
                  commentText: snap['comment'],
                  profileUrl: snap['profile'],
                );
              },
            );
          } else if (!snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text(snapshot.error.toString());
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          // color: Colors.red,
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1690751472154-0b608942106c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"),
                radius: 18,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: "Comment",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods.addComment(
                      uid: _user.uid,
                      name: _user.name,
                      postId: widget.postId,
                      commentText: _commentController.text,
                      profileUrl:
                          Provider.of<UserProvider>(context, listen: false)
                              .getUser!
                              .profileUrl);
                },
                child: const Text(
                  "Post",
                  style: TextStyle(color: blueColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
