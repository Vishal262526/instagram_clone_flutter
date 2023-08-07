import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/components/follow_button.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.userId,
  });
  final String? userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  User? _user;
  int totalPost = 0;

  @override
  void initState() {
    // TODO: implement initState
    initUser();
    super.initState();
  }

  void initUser() async {
    if (widget.userId == null) {
      _user = Provider.of<UserProvider>(context, listen: false).getUser;
      totalPost = await FirestoreMethods.getTotalPost(_user!.uid);
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                centerTitle: false,
                title: Text(_user!.username),
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
                            // backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(_user!.profileUrl),
                            radius: 40,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildStackColumn(totalPost, "Posts"),
                                buildStackColumn(
                                    _user!.followers.length, "Followers"),
                                buildStackColumn(
                                    _user!.following.length, "Following"),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(_user!.name),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: FollowButton(
                            title: 'Edit Profile',
                            borderColor: primaryColor,
                            backgroundColor: Colors.transparent,
                            onTap: () {},
                            isLoading: false,
                          ))
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
            ),
    );
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
}
