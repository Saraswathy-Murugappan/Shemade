import 'package:flutter/material.dart';
import '../profile_screen.dart'; // ✅ Import Profile Screen

class SellerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      body: Center(child: Text("Seller Home Page")),
    );
  }
}
