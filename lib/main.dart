import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_wave/screens/homescreen/provider_home_screen.dart';
import 'package:sound_wave/utils/routes.dart';

import 'screens/provider_botm_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderHomeScreen()),
        ChangeNotifierProvider(create: (context) => ProBottomNav()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Routes.splashScreen,
        routes: getAppRoutes(),
      ),
    );
  }
}
