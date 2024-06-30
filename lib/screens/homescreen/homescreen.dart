import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_wave/screens/homescreen/provider_home_screen.dart';
import 'package:sound_wave/utils/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final getSongsPro =
          Provider.of<ProviderHomeScreen>(context, listen: false);
      getSongsPro.getSongsFromExterStorg();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppThemes.primaryGradient,
        ),
        width: double.infinity,
      ),
    );
  }
}
