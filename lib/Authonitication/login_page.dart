// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/Auth_Cubit/auth_cubit.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          showSnackBar(context, 'Login successfully!');
          Navigator.pushNamed(context, 'ChatScreen', arguments: email);
          emailcontroller.clear();
          passwordcontroller.clear();
        } else if (state is LoginFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
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
                        height: 120,
                      ),
                      Lottie.asset(
                        'assets/Login.json',
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
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                            BlocProvider.of<AuthCubit>(context).loginMethod(
                                email: email!, password: password!);
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
          ),
        );
      },
    );
  }
}
