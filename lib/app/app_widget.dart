import 'package:fl_ide/routes.dart';
import 'package:fl_ide/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routefly/routefly.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          THEMES['androidstudio']!['root']?.backgroundColor, // Cor desejada
    ));
    return MaterialApp.router(
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.aplash,
      ),
      //darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      /*  theme: ThemeData.from(
        // colorScheme: ColorScheme.dark(

        /*           onBackground:   THEMES['androidstudio']!['root']?.backgroundColor,
           background: THEMES['androidstudio']!['root']?.backgroundColor, */

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: THEMES['androidstudio']!['root']?.backgroundColor,
          accentColor: THEMES['androidstudio']!['root']?.backgroundColor,
          backgroundColor: THEMES['androidstudio']!['root']?.backgroundColor,
        ),
      ), */
    );
  }
}
