import 'package:flutter/material.dart';

class AppColors {
  static const Color blueGradient = Color.fromARGB(255, 66, 132, 187);
  static const Color purple = Colors.purple;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static Color blue = Colors.blue.shade500;
}

class AppThemes {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.blueGradient, AppColors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
