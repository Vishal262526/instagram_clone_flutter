import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/primary_button.dart';
import '../components/text_field_input.dart';
import '../utils/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

                    //TextField input for name
                    TextFieldInput(
                      controller: _fullNameController,
                      placeholder: 'Full Name',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // TextField input for Full Name
                    TextFieldInput(
                      controller: _usernameController,
                      placeholder: 'Username',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
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
                    PrimaryButton(title: 'Signup', onTap: () {}),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(text: "If you already have an account "),
                  TextSpan(
                    text: "Log in",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
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
      ),
    );
  }
}
