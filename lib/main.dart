import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shemade/providers/user_provider.dart';
import 'package:shemade/screens/splash_screen.dart';
import 'package:shemade/screens/auth/signup_screen.dart';
import 'package:shemade/screens/home/buyer_home_screen.dart';
import 'package:shemade/screens/home/seller_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp();

  // ✅ Load Shared Preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isSignedUp = prefs.getBool('isSignedUp') ?? false;
  String? userRole = prefs.getString('userRole');
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(MyApp(
    isSignedUp: isSignedUp,
    userRole: userRole,
    hasSeenOnboarding: hasSeenOnboarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool isSignedUp;
  final String? userRole;
  final bool hasSeenOnboarding;

  const MyApp({
    required this.isSignedUp,
    this.userRole,
    required this.hasSeenOnboarding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: hasSeenOnboarding
            ? (isSignedUp
            ? (userRole == 'seller' ? SellerHomeScreen() : BuyerHomeScreen())
            : SignUpScreen())
            : SplashScreen(),
      ),
    );
  }
}
