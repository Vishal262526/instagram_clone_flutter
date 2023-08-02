import 'package:flutter/cupertino.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Profile Screen",
        style: TextStyle(
          fontSize: 20,
          color: primaryColor,
        ),
      ),
    );
  }
}
