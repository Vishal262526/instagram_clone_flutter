import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isLoading});

  final String title;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        // padding: const Edge=Insets.symmetric(vertical: 8, horizontal:8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: blueColor),
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
