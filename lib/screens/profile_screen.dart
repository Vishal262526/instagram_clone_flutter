import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/firebase/auth.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ElevatedButton(
            onPressed: () async {
              await Auth.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text("Logout")));
  }
}
