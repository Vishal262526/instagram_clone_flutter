import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/models/post.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    if (post.likes.contains(
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
                    post.username,
                    style: const TextStyle(
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                  ))
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(post.postImage),
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
                            post.id);
                      } else {
                        await FirestoreMethods.insertLike(
                            Provider.of<UserProvider>(context, listen: false)
                                .getUser!
                                .uid,
                            post.id);
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
                    onPressed: () {},
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
                "${post.likes.length} Likes",
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
                      text: "${post.username} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: post.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  "View all are 200 Comments",
                  style: TextStyle(
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
                  post.publishedDate,
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
