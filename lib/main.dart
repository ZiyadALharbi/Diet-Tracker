import 'package:diet_tracker/core/styles/app_colors.dart';
import 'package:diet_tracker/features/onBoarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  static _MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>()!;
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Diet Tracker",
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(), // to be changed to custom
      themeMode: _themeMode, // device controls theme
      home: const OnboardingPage(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.lightPrimary,
          secondary: AppColors.lightSecondary,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightPrimary,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.lightText1),
          bodyMedium: TextStyle(color: AppColors.lightText2),
          bodySmall: TextStyle(color: AppColors.lightText3),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.lightBottomNavBar,
          selectedItemColor: AppColors.lightPrimary,
        ));
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkPrimary,
          secondary: AppColors.darkSecondary,
        ),
        scaffoldBackgroundColor: const Color(0x000d0d0d),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0x000d0d0d),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkPrimary,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.darkText1),
          bodyMedium: TextStyle(color: AppColors.darkText2),
          bodySmall: TextStyle(color: AppColors.darkText3),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.darkBottomNavBar,
            selectedItemColor: AppColors.darkPrimary));
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Diet Tracker"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () =>
                      MainApp.of(context).changeTheme(ThemeMode.light),
                  child: const Text("Light Mode")),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () =>
                      MainApp.of(context).changeTheme(ThemeMode.dark),
                  child: const Text("Dark Mode")),
            ],
          ),
        ));
  }
}
