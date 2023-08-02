import 'package:flutter/cupertino.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Search Screen",
        style: TextStyle(
          fontSize: 20,
          color: primaryColor,
        ),
      ),
    );
  }
}
