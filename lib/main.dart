import 'package:chat_app/Authonitication/login_page.dart';
import 'package:chat_app/Authonitication/register_page.dart';
import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/splash_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:chat_app/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'RegisterPage': (context) => const RegisterPage(),
        'LoginPage': (context) => const LoginPage(),
        'SplashScreen': (context) => const SplashScreen(),
        'ChatScreen': (context) => ChatScreen()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'SplashScreen',
    );
  }
}
