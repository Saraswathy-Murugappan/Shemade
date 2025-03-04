import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../home/buyer_home_screen.dart';
import '../home/seller_home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedRole;

  void _completeSignUp(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedUp', true);
    await prefs.setString('userRole', role);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => role == 'seller' ? SellerHomeScreen() : BuyerHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Choose your role"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _completeSignUp("buyer"),
              child: Text("Sign Up as Buyer"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _completeSignUp("seller"),
              child: Text("Sign Up as Seller"),
            ),
          ],
        ),
      ),
    );
  }
}
