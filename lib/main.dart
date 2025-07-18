import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todostuffs/mainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved theme mode from shared preferences
  final prefs = await SharedPreferences.getInstance();
  final isDarkmode = prefs.getBool('isDark') ?? false;

  runApp(MyApp(initialDarkMode: isDarkmode));
}

class MyApp extends StatefulWidget {
  final bool initialDarkMode;
  const MyApp({super.key, required this.initialDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkmode;

  @override
  void initState() {
    super.initState();
    isDarkmode = widget.initialDarkMode;
  }

  void toggleTheme() async {
    setState(() {
      isDarkmode = !isDarkmode;
    });

    // Save the theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDarkmode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkmode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Mainscreen(
        toggleTheme: toggleTheme,
        isDarkmode: isDarkmode,
      ),
    );
  }
}
