import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/components/primary_button.dart';
import 'package:instagram_clone_flutter/components/text_field_input.dart';
import 'package:instagram_clone_flutter/firebase/auth.dart';
import 'package:instagram_clone_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_clone_flutter/screens/signup_screen.dart';
import 'package:instagram_clone_flutter/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          text,
        ),
      ),
    );
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
            webScreen: WebScreenLayout(), mobileScreen: MobileScreenLayout()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        padding: kHorizontalPadding,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Svg Logo
                  SvgPicture.asset(
                    'assets/logo.svg',
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  // TextField input for Email
                  TextFieldInput(
                    controller: _emailController,
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // TextField input for Password
                  TextFieldInput(
                    controller: _passwordController,
                    placeholder: 'Password',
                    keyboardType: TextInputType.text,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Login Button
                  PrimaryButton(
                    isLoading: _isLoading,
                    title: 'Login',
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      final Auth auth = Auth();

                      final res = await auth.loginUser(
                          _emailController.text, _passwordController.text);
                      if (res['success']) {
                        _isLoading = false;
                        if (mounted) {
                          setState(() {});
                        }
                        navigateToHomeScreen();
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        showSnackbar(res['err'].toString());
                      }
                    },
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(children: <TextSpan>[
                const TextSpan(text: "If you don't have an account "),
                TextSpan(
                  text: "Sign Up",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                ),
              ]),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    ));
  }
}
