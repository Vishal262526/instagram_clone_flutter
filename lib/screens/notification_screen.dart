import 'package:flutter/cupertino.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Notification Screen",
        style: TextStyle(
          fontSize: 20,
          color: primaryColor,
        ),
      ),
    );
  }
}
