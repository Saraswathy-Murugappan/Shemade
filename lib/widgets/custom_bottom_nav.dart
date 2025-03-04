import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isSeller;

  CustomBottomNav({required this.currentIndex, required this.onTap, required this.isSeller});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: isSeller
          ? [BottomNavigationBarItem(icon: Icon(Icons.store), label: "My Store"), BottomNavigationBarItem(icon: Icon(Icons.request_page), label: "Requests")]
          : [BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"), BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Orders")],
    );
  }
}
