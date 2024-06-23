import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/auth/splash_screen.dart';
import 'package:taskmanager/ui/utility/app_colors.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: lightThemeData()
    );
  }
}

ThemeData lightThemeData(){
  return ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.white,
        filled: true,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        hintStyle: TextStyle(color: Colors.grey.shade400)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.themeColor,
          padding: EdgeInsets.symmetric(vertical: 12),
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          )
      ),
    ),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w400
      )
    ),
  );
}