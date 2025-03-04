import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileIcon extends StatefulWidget {
  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  String? userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: Column(
        children: [
          Icon(Icons.person, size: 40),
          if (userRole != null)
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
              ),
              child: Column(
                children: [
                  Text("Role: $userRole"),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushReplacementNamed(context, "/signup");
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
