import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_wave/screens/all_songs/all_songs_screen.dart';
import 'package:sound_wave/screens/homescreen/homescreen.dart';
import 'package:sound_wave/utils/theme.dart';

import 'provider_botm_nav.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationScreen> {
  final PageController controller = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<ProBottomNav>(
        builder: (context, appState, child) {
          return BottomBarBubble(
            backgroundColor: Colors.purple.shade800,
            color: AppColors.blue,
            items: [
              BottomBarItem(
                iconBuilder: (color) => Icon(Icons.music_note,
                    size: appState.selectedIndex == 0 ? 32 : 25,
                    color: appState.selectedIndex == 0
                        ? AppColors.blue
                        : AppColors.white),
              ),
              BottomBarItem(
                iconData: Icons.chat,
              ),
              BottomBarItem(
                iconBuilder: (color) => Icon(Icons.home,
                    size: appState.selectedIndex == 2 ? 32 : 25,
                    color: appState.selectedIndex == 2
                        ? AppColors.blue
                        : AppColors.white),
              ),
              BottomBarItem(
                iconData: Icons.calendar_month,
              ),
              BottomBarItem(
                iconData: Icons.settings,
              ),
            ],
            selectedIndex: appState.selectedIndex,
            onSelect: (index) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                appState.setSelectedIndex(index);
                controller.jumpToPage(index);
              });
            },
          );
        },
      ),
      body: Consumer<ProBottomNav>(
        builder: (context, appState, child) {
          return PageView(
            controller: controller,
            onPageChanged: (index) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                appState.setSelectedIndex(index);
              });
            },
            children: const <Widget>[
              AllSongsScreen(),
              Center(
                child: Text('Second Page'),
              ),
              HomeScreen(),
              Center(
                child: Text('Four Page'),
              ),
              Center(
                child: Text('Five Page'),
              ),
            ],
          );
        },
      ),
    );
  }
}
