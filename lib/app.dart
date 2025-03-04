import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shemade/screens/auth/signup_screen.dart';
import 'package:shemade/screens/home/buyer_home_screen.dart';
import 'package:shemade/screens/home/seller_home_screen.dart';
import 'package:shemade/providers/user_provider.dart';

class App extends StatefulWidget {
  final bool isSignedUp;
  final String? userRole;

  const App({required this.isSignedUp, this.userRole, Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _loadUser(); // Load user details on app start
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('userRole');
    Provider.of<UserProvider>(context, listen: false).loadUserFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSignedUp) {
      return SignUpScreen();
    }
    return widget.userRole == 'seller' ? SellerHomeScreen() : BuyerHomeScreen();
  }
}
