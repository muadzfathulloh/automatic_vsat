import 'package:automatic_vsat_v1/common/routes.dart';
import 'package:automatic_vsat_v1/common/utils.dart';
import 'package:automatic_vsat_v1/pages/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoVSAT',
      theme: ThemeData().copyWith(colorScheme: kColorScheme),
      home: const OnBoardingScreen(),
      navigatorKey: navigatorKey,
      initialRoute: OnBoardingScreen.routeName,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
      },
    );
  }
}
