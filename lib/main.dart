import 'package:flutter/material.dart';
import 'package:todostuffs/mainScreen.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool isDarkmode = false;

  void toggleTheme () {
    setState(() {
      isDarkmode = !isDarkmode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkmode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home:Mainscreen(
        toggleTheme: toggleTheme,
        isDarkmode: isDarkmode,
      ),
    );
  }
}