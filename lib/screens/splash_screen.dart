import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.network(
          'https://www.svgrepo.com/show/452178/cart.svg', // Replace with your SVG URL
          width: 200,
          height: 200,
          color: Colors.pink,
        ),
      ),
    );
  }
}
