import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider_botm_nav.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationScreen> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<ProBottomNav>(
        builder: (context, appState, child) {
          return BottomBarBubble(
            items: [
              BottomBarItem(
                iconData: Icons.home,
              ),
              BottomBarItem(
                iconData: Icons.chat,
              ),
              BottomBarItem(
                iconData: Icons.notifications,
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
              Center(
                child: Text('First Page'),
              ),
              Center(
                child: Text('Second Page'),
              ),
              Center(
                child: Text('Third Page'),
              ),
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
