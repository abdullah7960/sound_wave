import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sound_wave/utils/routes.dart';
import 'package:sound_wave/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _progress += 20;
        if (_progress < 100) {
          _simulateLoading();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppThemes.primaryGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              const Icon(
                Icons.music_note,
                size: 100,
                color: AppColors.white,
              ),
              SizedBox(height: height * .02),
              const Text(
                'My Audio Player',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * .02),
              SizedBox(
                height: height * 0.05,
                width: width,
                child: LinearPercentIndicator(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  animation: true,
                  animationDuration: 500,
                  lineHeight: 20.0,
                  percent: _progress / 100,
                  barRadius: const Radius.circular(20),
                  center: Text(
                    "$_progress%",
                    style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                  progressColor: AppColors.blue,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              SizedBox(height: height * .02),
              const Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: _progress >= 100
          ? FloatingActionButton.extended(
              onPressed: () {
                // Navigate to the next screen
                Navigator.pushReplacementNamed(
                    context, Routes.bottomNavigation);
              },
              label: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(Icons.arrow_forward),
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.blue,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
