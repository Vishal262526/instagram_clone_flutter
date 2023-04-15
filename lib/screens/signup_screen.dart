import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/firebase/auth.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import '../components/primary_button.dart';
import '../components/text_field_input.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

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
  final TextEditingController _bioController = TextEditingController();

  // Some Variables
  Uint8List? _image;
  bool isLoading = false;

  // Go to Home Screen
  void navigateToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void selectImage() async {
    final pickedImage = await pickimage(ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      height: 24,
                    ),
                    // Circular Widget to accept an image
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundColor: blueColor,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 64,
                                ),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    //TextField input for name
                    TextFieldInput(
                      controller: _fullNameController,
                      placeholder: 'Name',
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
                    TextFieldInput(
                      controller: _bioController,
                      placeholder: 'Bio',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Login Button
                    PrimaryButton(
                      isLoading: isLoading,
                      title: 'Signup',
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final Auth auth = Auth();
                        final Map response = await auth.signupUser(
                            email: _emailController.text,
                            password: _passwordController.text,
                            fullName: _fullNameController.text,
                            bio: _bioController.text,
                            username: _usernameController.text,
                            profile: _image);
                        if (response['success']) {
                          setState(() {
                            isLoading = false;
                          });
                          navigateToHomeScreen();
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                response['err'],
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }
                      },
                    ),
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
