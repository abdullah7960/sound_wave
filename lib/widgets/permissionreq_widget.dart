import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class PermissionRequiredMessage extends StatelessWidget {
  final double height;

  const PermissionRequiredMessage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: Colors.red,
      child: Center(
        child: Text(
          "Permission Required to Access External Storage",
          style: TextStyle(
            fontSize: height * 0.02,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
