import 'package:flutter/material.dart';

class AppColors {
  static const Color blue = Colors.blue;
  static const Color purple = Colors.purple;
}

class AppThemes {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.blue, AppColors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
