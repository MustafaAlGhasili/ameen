import 'package:ameen/services/LocalStorageService.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/admin/home.dart';
import 'package:ameen/view/ui/home/home.dart';
import 'package:ameen/view/ui/sign/start.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<Widget> _nextScreen;

  @override
  void initState() {
    super.initState();

    _nextScreen = _getNextScreen();
  }

  Future<Widget> _getNextScreen() async {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    int? userType = await LocalStorageService.getUserType();

    if (userType != null && isLoggedIn) {
      switch (userType) {
        case 0: // Parent
          return const Home();
        case 2: // Admin
          return const AdminHome();
        default:
          return const Start();
      }
    } else {
      return const Start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'img/logo.png',
      splashIconSize: 150,
      backgroundColor: PRIMARY_COLOR,
      nextScreen: FutureBuilder<Widget>(
        future: _nextScreen,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data ?? const Start();
          } else {
            return const SizedBox();
          }
        },
      ),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
    );
  }
}
