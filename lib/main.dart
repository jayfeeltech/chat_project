
import 'package:chat_project/colors.dart';
import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      theme:AppTheme.light(
        
      ),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,

      home: HomeScreen(),
    );
  }
}
