import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone_flutter/firebase/firestore.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future? user;
  Future? post;
  bool isShowUser = false;

  @override
  void dispose() {
    // TODO: implement dispose

    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              label: Text("Search"),
            ),
            onChanged: (value) async {
              if (value != "") {
                user = FirestoreMethods.getSearchedUser(value);
                isShowUser = true;
                setState(() {});
              } else {
                isShowUser = false;
                setState(() {});
              }
            },
          ),
        ),
        body: isShowUser
            ? FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data.docs[index]['username']);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data.docs[index]['profile_url']),
                          ),
                          title: Text(snapshot.data.docs[index]['username']),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            : FutureBuilder(
                future: FirestoreMethods.firestore.collection('post').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              ));
  }
}
