import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/models/post.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/screens/comment_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isDoubleTap = false;
  int commentCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    getCommentCount();
    super.initState();
  }

  void getCommentCount() async {
    try {
      final QuerySnapshot snap = await FirestoreMethods.firestore
          .collection('post')
          .doc(widget.post.id)
          .collection('comments')
          .get();
      setState(() {
        commentCount = snap.docs.length;
      });
    } catch (e) {
      print("Something went wrong........");
      commentCount = 0;
    }
  }

  void _deletePost() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Post"),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                goBack();
                await FirestoreMethods.deletePost(postId: widget.post.id);
              },
              padding: const EdgeInsets.all(20.0),
              child: const Text("Delete Post"),
            ),
          ],
        );
      },
    );
  }

  void goBack() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    if (widget.post.likes.contains(
      Provider.of<UserProvider>(context, listen: false).getUser!.uid,
    )) {
      isLiked = true;
    } else {
      isLiked = false;
    }
    return Container(
      color: mobileBackgroundColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                spacing: 8.0,
                children: [
                  const CircleAvatar(
                    backgroundColor: primaryColor,
                  ),
                  Text(
                    widget.post.username,
                    style: const TextStyle(
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              if (widget.post.uid ==
                  Provider.of<UserProvider>(context, listen: false)
                      .getUser!
                      .uid)
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: _deletePost,
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.post.postImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20.0,
                direction: Axis.horizontal,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () async {
                      if (isLiked) {
                        await FirestoreMethods.removeLike(
                            Provider.of<UserProvider>(context, listen: false)
                                .getUser!
                                .uid,
                            widget.post.id);
                      } else {
                        await FirestoreMethods.insertLike(
                            Provider.of<UserProvider>(context, listen: false)
                                .getUser!
                                .uid,
                            widget.post.id);
                      }
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: isLiked ? Colors.red : primaryColor,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentScreen(
                            postId: widget.post.id,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.comment_outlined,
                      color: primaryColor,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send_outlined,
                      color: primaryColor,
                      size: 32,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark,
                  color: primaryColor,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              Text(
                "${widget.post.likes.length} Likes",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: primaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: "${widget.post.username} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.post.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentScreen(
                        postId: widget.post.id,
                      ),
                    ),
                  );
                },
                child: Text(
                  "View all are $commentCount Comments",
                  style: const TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  widget.post.publishedDate.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
