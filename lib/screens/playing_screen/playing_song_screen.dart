import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../utils/theme.dart';

class PlayingSongScreen extends StatefulWidget {
  const PlayingSongScreen({super.key});

  @override
  State<PlayingSongScreen> createState() => _PlayingSongScreenState();
}

class _PlayingSongScreenState extends State<PlayingSongScreen> {
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
            children: [
              SizedBox(
                height: height * .05,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(
                    width: width * .2,
                  ),
                  const Text(
                    'Now Playing',
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.04,
                child: Marquee(
                  text: "providerHandler.currentSongTitle!",
                  style:
                      TextStyle(fontSize: height * .02, color: AppColors.white),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/item_song_img/song2.png'),
              ),
              SizedBox(
                height: height * .01,
                width: width * 1,
                child: Slider(
                  value: 1,
                  max: 12,
                  onChanged: (value) {},
                  activeColor: AppColors.blue,
                  inactiveColor: Colors.grey[300],
                ),
              ),
              Row(
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
