// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? email, password;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Lottie.asset(
                  'assets/chat_animation.json',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome Back !',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                CutomTextFormField(
                  controller: emailcontroller,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: primaryColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is required';
                    }
                  },
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CutomTextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is required';
                    }
                  },
                  obscureText: _obscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: primaryColor,
                    ),
                  ),
                  onChanged: (data) {
                    password = data;
                  },
                  prefixIcon: const Icon(
                    Icons.password,
                    color: primaryColor,
                  ),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await loginMethod();
                        showSnackBar(context, 'Login successfully!');
                        Navigator.pushNamed(context, 'ChatScreen',
                            arguments: email);
                        emailcontroller.clear();
                        passwordcontroller.clear();
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isLoading = false;
                        }); // Stop loading animation

                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        } else {
                          showSnackBar(context, 'There was an error');
                        }
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        }); // Stop loading animation
                        showSnackBar(context, 'There was an Error');
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginMethod() async {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
