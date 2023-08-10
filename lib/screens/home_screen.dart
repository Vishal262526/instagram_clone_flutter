import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_flutter/components/post_card.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/models/post.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String username;
  late Stream posts;

  void getUsername() async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (mounted) {
      setState(() {
        username = (user.data() as Map)['name'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posts = FirestoreMethods.getAllPost();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset(
            "assets/logo.svg",
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.message_outlined))
          ],
        ),
        body: StreamBuilder(
          stream: posts,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // final Post currentPost =
                  //     Post.fromDocumentSnapshot(snapshot.data![index].docs);
                  final Post currentPost =
                      Post.fromDocumentSnapshot(snapshot.data!.docs[index]);

                  return PostCard(post: currentPost);
                },
              );
            }
          },
        ));
  }
}
