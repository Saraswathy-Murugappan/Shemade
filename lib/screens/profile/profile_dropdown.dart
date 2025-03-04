import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';

import '../auth/login_screen.dart';

class ProfileDropdown extends StatefulWidget {
  @override
  _ProfileDropdownState createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  // ✅ Generate Gravatar URL from email
  String _getGravatarUrl(String? email) {
    if (email == null || email.isEmpty) {
      return "https://www.gravatar.com/avatar/?d=mp";
    }
    final bytes = utf8.encode(email.trim().toLowerCase());
    final hash = md5.convert(bytes);
    return "https://www.gravatar.com/avatar/$hash?d=mp";
  }

  // ✅ Logout user (Firebase + SharedPreferences)
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Logout from Firebase
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear stored data
    Provider.of<UserProvider>(context, listen: false).logout(); // Update Provider
    setState(() {
      _isDropdownOpen = false; // Close dropdown
    });

    // Navigate to Login Screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    String profilePic = _getGravatarUrl(user?.email);

    return GestureDetector(
      onTap: _toggleDropdown,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(profilePic),
            radius: 25, // Profile size
          ),

          // Dropdown Menu
          if (_isDropdownOpen)
            Positioned(
              right: 0,
              top: 60,
              child: Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dropdownItem(Icons.person, "Name: ${user?.name ?? 'User'}"),
                      _dropdownItem(Icons.email, "Email: ${user?.email ?? 'No Email'}"),
                      _dropdownItem(Icons.verified_user, "Role: ${user?.role ?? 'Unknown'}"),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.exit_to_app, color: Colors.red),
                        title: Text("Logout", style: TextStyle(color: Colors.red)),
                        onTap: () => _logout(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper for Dropdown Items
  Widget _dropdownItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.pink[700]),
          SizedBox(width: 10),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
