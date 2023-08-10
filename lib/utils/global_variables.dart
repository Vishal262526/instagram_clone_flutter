import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../screens/add_post_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../firebase/auth.dart';

// Max Size to decide render an web or mobile screen
const int webScreenSize = 600;

// All screens
List<Widget> screens = [
  const HomeScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const NotificationScreen(),
  ProfileScreen(userId: FirebaseAuth.instance.currentUser!.uid),
];

// All Bottom Navigation items
const List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    icon: Icon(
      Icons.home,
    ),
    label: "",
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.search,
    ),
    label: "",
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.add_circle,
    ),
    label: "",
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.favorite,
    ),
    label: "",
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.person,
    ),
    label: "",
  ),
];
