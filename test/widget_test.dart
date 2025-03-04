import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shemade/main.dart';
import 'package:shemade/providers/user_provider.dart';
import 'package:shemade/screens/auth/signup_screen.dart';
import 'package:shemade/screens/home/buyer_home_screen.dart';
import 'package:shemade/screens/home/seller_home_screen.dart';

void main() {
  group('App Navigation Tests', () {
    testWidgets('Shows SignUpScreen if user is not signed up', (WidgetTester tester) async {
      // ✅ Load app with user not signed up
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: MaterialApp(
            home: MyApp(isSignedUp: false, userRole: null, hasSeenOnboarding: true),
          ),
        ),
      );

      // ✅ Wait for all UI to settle
      await tester.pumpAndSettle();

      // ✅ Expect "Sign Up" screen elements
      expect(find.byType(SignUpScreen), findsOneWidget);
    });

    testWidgets('Shows BuyerHomeScreen if user is a buyer', (WidgetTester tester) async {
      // ✅ Load app with buyer role
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: MaterialApp(
            home: MyApp(isSignedUp: true, userRole: 'buyer', hasSeenOnboarding: true),
          ),
        ),
      );

      // ✅ Wait for UI to settle
      await tester.pumpAndSettle();

      // ✅ Expect BuyerHomeScreen to be shown
      expect(find.byType(BuyerHomeScreen), findsOneWidget);
    });

    testWidgets('Shows SellerHomeScreen if user is a seller', (WidgetTester tester) async {
      // ✅ Load app with seller role
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: MaterialApp(
            home: MyApp(isSignedUp: true, userRole: 'seller', hasSeenOnboarding: true),
          ),
        ),
      );

      // ✅ Wait for UI to settle
      await tester.pumpAndSettle();

      // ✅ Expect SellerHomeScreen to be shown
      expect(find.byType(SellerHomeScreen), findsOneWidget);
    });
  });
}
