import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isLoading,
    required this.borderColor,
    this.backgroundColor = blueColor,
  });

  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final Color borderColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 30,
        width: double.infinity,
        alignment: Alignment.center,
        // padding: const Edge=Insets.symmetric(vertical: 8, horizontal:8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            )),
        child: isLoading
            ? const CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.white,
              )
            : Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
