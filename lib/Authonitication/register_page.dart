// ignore_for_file: unused_local_variable

import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/Auth_Cubit/auth_cubit.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password, confirmPassword;

  bool isLoading = false;
  bool _obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          showSnackBar(context, 'Account created successfully!');
          Navigator.pushNamed(context, 'LoginPage', arguments: email);
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Lottie.asset(
                        'assets/Login.json',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Welcome !',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CutomTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          }
                        },
                        hintText: 'Enter your FullName',
                        labelText: 'User Name',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CutomTextFormField(
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
                        prefixIcon: const Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CutomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        obscureText: _obscureText,
                        prefixIcon: const Icon(
                          Icons.password,
                          color: primaryColor,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CutomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onChanged: (data) {
                          confirmPassword = data;
                        },
                        hintText: 'Enter your password again',
                        labelText: 'Confirm Password',
                        obscureText: _obscureText,
                        prefixIcon: const Icon(
                          Icons.password,
                          color: primaryColor,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (password != confirmPassword) {
                              showSnackBar(context, 'Passwords do not match');
                            } else {
                              BlocProvider.of<AuthCubit>(context)
                                  .registerMethod(
                                      email: email!, password: password!);
                            }
                          }
                        },
                        text: 'Sign Up',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
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
          ),
        );
      },
    );
  }
}
