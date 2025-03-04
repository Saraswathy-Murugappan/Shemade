import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';
import '../../screens/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: user == null
          ? Center(child: Text("No user data found"))
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: user.profilePic != null && user.profilePic!.isNotEmpty
                ? NetworkImage(user.profilePic!)  // ✅ Use user profile picture
                : NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"), // ✅ Default avatar
          ),

          SizedBox(height: 10),
          Text(user.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(user.email, style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
              );
            },
            child: Text("Logout"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
