import 'package:dota_hero_list/screen/pages/pages.dart';
import 'package:dota_hero_list/services/hero_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/theme.dart';
import 'shared/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HeroProvider>(
            create: (context) => HeroProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: cBlack,
          appBarTheme: AppBarTheme(color: cBlack),
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: NoWaveScroll(),
            child: child!,
          );
        },
        home: const SplashPage(),
      ),
    );
  }
}
