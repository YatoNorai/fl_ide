import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:fl_ide/routes.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor:
          Colors.white /* THEMES['androidstudio']!['root']?.backgroundColor */,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
        Routefly.navigate(routePaths.home);
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("assets/icons/ic_launcher.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      //  nextScreen: const StartPage(),
    );
  }
}
