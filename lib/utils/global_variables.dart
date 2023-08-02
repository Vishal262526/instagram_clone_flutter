import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

// Max Size to decide render an web or mobile screen
const int webScreenSize = 600;

// All screens
const List<Widget> screens = [
  HomeScreen(),
  SearchScreen(),
  AddPostScreen(),
  NotificationScreen(),
  ProfileScreen(),
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
