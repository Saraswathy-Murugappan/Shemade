import 'package:flutter/material.dart';
import '../profile_screen.dart'; // ✅ Import Profile Screen

class BuyerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyer Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      body: Center(child: Text("Buyer Home Page")),
    );
  }
}
