import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_gpa_calculator/screens/splash_screen.dart';
import 'package:smart_gpa_calculator/utils/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  
  runApp(SmartGPAApp(isDarkMode: isDarkMode));
}

class SmartGPAApp extends StatelessWidget {
  final bool isDarkMode;
  
  const SmartGPAApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkMode: isDarkMode,
      child: MaterialApp(
        title: 'Smart GPA Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeProvider.lightTheme,
        darkTheme: ThemeProvider.darkTheme,
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
