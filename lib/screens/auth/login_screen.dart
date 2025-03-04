import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';
import '../home/buyer_home_screen.dart';
import '../home/seller_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isSeller = false;

  @override
  void initState() {
    super.initState();
    _checkUserLogin();
  }

  Future<void> _checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSignedUp = prefs.getBool('isSignedUp') ?? false;
    String? userRole = prefs.getString('userRole');

    if (isSignedUp && userRole != null) {
      // If user data exists, load from provider and navigate
      Provider.of<UserProvider>(context, listen: false).loadUserFromPrefs();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => userRole == "seller" ? SellerHomeScreen() : BuyerHomeScreen(),
        ),
      );
    }
  }

  void _handleGoogleSignIn() async {
    User? firebaseUser = await _authService.signInWithGoogle();
    if (firebaseUser != null) {
      _saveUserAndNavigate(firebaseUser);
    }
  }

  void _saveUserAndNavigate(User firebaseUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedUp', true);
    await prefs.setString('userRole', _isSeller ? "seller" : "buyer");

    UserModel user = UserModel(
      uid: firebaseUser.uid,
      name: firebaseUser.displayName ?? "User",
      email: firebaseUser.email ?? "",
      role: _isSeller ? "seller" : "buyer",
    );

    Provider.of<UserProvider>(context, listen: false).setUser(user);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _isSeller ? SellerHomeScreen() : BuyerHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", height: 100),
              SizedBox(height: 20),
              Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pink[800]),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _handleGoogleSignIn,
                icon: Image.asset("assets/google.png", height: 24),
                label: Text("Sign in with Google"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 3,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.pink[100],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    _roleButton("Buyer", !_isSeller),
                    _roleButton("Seller", _isSeller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleButton(String text, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSeller = text == "Seller";
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isActive ? Colors.pink[700] : Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.pink[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
