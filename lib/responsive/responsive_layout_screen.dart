import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    super.key,
    required this.webScreen,
    required this.mobileScreen,
  });

  final Widget webScreen;
  final Widget mobileScreen;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  late Future refreshUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("Init State is Starting");
    refreshUser =
        Provider.of<UserProvider>(context, listen: false).refreshUser();
    // print("User Refreshed");
    // addData();

    print("Init State is End");
  }

  // void addData() async {
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   await userProvider.refreshUser();
  //   print("Refreshed");
  // }

  @override
  Widget build(BuildContext context) {
    print("Build is Called");
    return FutureBuilder(
      future: refreshUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("Checking user data ..............");
          print(Provider.of<UserProvider>(context, listen: false).getUser);

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > webScreenSize) {
                return widget.webScreen;
              } else {
                return widget.mobileScreen;
              }
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              color: blueColor,
            ),
          );
        } else {
          return Container(
            child: const Text("Something Went Wrong"),
          );
        }
      },
    );
  }
}
