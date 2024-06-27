import 'package:flutter/material.dart';
import 'package:sound_wave/screens/album/album_list_screen.dart';
import 'package:sound_wave/screens/homescreen/homescreen.dart';
import 'package:sound_wave/screens/splash_screen.dart';

import '../screens/bottom_navigation.dart';

class Routes {
  static const String albumListScreen = '/albumListScreen';
  static const String albumSongsListScreen = '/albumsongsListScreen';
  static const String allSongScreen = '/allSongscreen';
  static const String artistListScreen = '/artistListScreen';
  static const String artistSongsListScreen = '/artistSongsListScreen';
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String onBoradingScreen = '/onBoradingScreen';
  static const String askAI = '/askAiScreen';
  static const String bottomNavigation = '/bottomNavigation';
}

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    Routes.albumListScreen: (context) => const AlbumListScreen(),
    Routes.splashScreen: (context) => const SplashScreen(),
    Routes.homeScreen: (context) => const HomeScreen(),
    Routes.bottomNavigation: (context) => const BottomNavigationScreen(),
  };
}
