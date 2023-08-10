import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/components/follow_button.dart';
import 'package:instagram_clone_flutter/firebase/auth.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/models/user.dart' as userModel;
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart'
    as userProvider;
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _user;
  int totalPost = 0;
  bool isFollowing = false;

  @override
  void initState() {
    // TODO: implement initState

    initUser();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  void initUser() async {
    final userModel.User currentUser =
        Provider.of<userProvider.UserProvider>(context, listen: false).getUser!;
    print(
        "Current user follwing data is .............. ${currentUser.following}");
    _user = FirestoreMethods.getSingleUserData(widget.userId);
    totalPost = await FirestoreMethods.getTotalPost(widget.userId);

    isFollowing = currentUser.following.contains(widget.userId);
    setState(() {});
  }

  void goTologinScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: StreamBuilder(
          stream: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            final userModel.User _user =
                userModel.User.fromDocumentSnapshot(snapshot.data!);

            return profileWdigets(_user);
          },
        ));
  }

  Widget buildStackColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label.toString(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget profileWdigets(userModel.User user) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Text(user.username),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  goTologinScreen();
                } catch (e) {
                  print(e.toString());
                }
              },
              icon: const Icon(
                Icons.logout_outlined,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: user.profileUrl != "no"
                        ? Image.network(user.profileUrl)
                        : Image.asset("assets/user.png"),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildStackColumn(totalPost, "Posts"),
                        buildStackColumn(user.followers.length, "Followers"),
                        buildStackColumn(user.following.length, "Following"),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(user.name),
              const SizedBox(
                height: 1,
              ),
              Text(
                user.bio,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: widget.userId != Auth.auth.currentUser!.uid
                        ? FollowButton(
                            title: isFollowing ? "Unfollow" : "follow",
                            borderColor: Colors.transparent,
                            backgroundColor:
                                isFollowing ? primaryColor : blueColor,
                            forgroundColor:
                                isFollowing ? Colors.black : primaryColor,
                            onTap: () async {
                              if (!isFollowing) {
                                final bool followingStatus =
                                    await FirestoreMethods.addFollowing(
                                        Provider.of<userProvider.UserProvider>(
                                                context,
                                                listen: false)
                                            .getUser!
                                            .uid,
                                        widget.userId);
                                if (followingStatus) {
                                  isFollowing = true;
                                  await Provider.of<userProvider.UserProvider>(
                                          context,
                                          listen: false)
                                      .refreshUser();

                                  print("Refreshed --------------- true");

                                  setState(() {});
                                }
                              } else {
                                final bool removeFollowingStatus =
                                    await FirestoreMethods.removeFollowing(
                                        Provider.of<userProvider.UserProvider>(
                                                context,
                                                listen: false)
                                            .getUser!
                                            .uid,
                                        widget.userId!);
                                if (removeFollowingStatus) {
                                  isFollowing = false;
                                  await Provider.of<userProvider.UserProvider>(
                                          context,
                                          listen: false)
                                      .refreshUser();
                                  print("Refreshed --------------- false");

                                  setState(() {});
                                }
                              }
                            },
                            isLoading: false,
                          )
                        : FollowButton(
                            title: "Edit Profile",
                            borderColor: primaryColor,
                            backgroundColor: Colors.transparent,
                            onTap: () {},
                            isLoading: false,
                          ),
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.post_add),
                  ),
                  Tab(
                    icon: Icon(Icons.post_add),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 190,
                child: TabBarView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text("Post"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Post"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
