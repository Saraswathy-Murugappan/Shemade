import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login_screen.dart'; // Import login screen

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  final List<String> _svgImages = [
    "https://www.svgrepo.com/show/47146/calendar.svg",
    "https://www.svgrepo.com/show/4945/womens-day.svg",
    "https://www.svgrepo.com/show/25899/family.svg",
  ];

  final List<String> _titles = [
    "Welcome to SheMade",
    "Empower Women Entrepreneurs",
    "Start Selling & Buying",
  ];

  final List<String> _descriptions = [
    "Discover unique products crafted by talented women entrepreneurs.",
    "Support and uplift women by engaging in a thriving marketplace.",
    "Easily list products or find what you love with secure transactions.",
  ];

  void _nextPage() async {
    if (_currentPage < _svgImages.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      // ✅ Store onboarding status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);

      // ✅ Navigate to Login Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SvgPicture.network(
              _svgImages[_currentPage], // Load the current network SVG image
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.contain,
              placeholderBuilder: (context) => CircularProgressIndicator(), // Loading indicator
            ),
          ),
          Text(
            _titles[_currentPage],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _descriptions[_currentPage],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: _nextPage,
            child: Text(_currentPage < _svgImages.length - 1 ? "Next" : "Get Started"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
