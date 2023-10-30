import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunnah_reminder/bottom_bar.dart';
import 'package:sunnah_reminder/controller.dart';
import 'package:sunnah_reminder/dashboard/dashboard.dart';
import 'package:sunnah_reminder/register.dart';
import 'package:sunnah_reminder/reminder/reminder_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sunnah_reminder/splash/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var controller = Get.put(Controller());
    // auth.box.wr
    const delay = Duration(seconds: 2);
    Future.delayed(delay, () => onTimerFinished(controller));
  }

  void onTimerFinished(Controller controller) {
    if (controller.box.hasData("username")) {
      Get.off(BottomBar(username: controller.box));
    } else {
      Get.to(WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF408840),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon(),
            Image.asset("assets/image/logo.png")
          ],
        ),
      ),
    );
  }
}

// Widget splashScreenIcon() {
//   String iconPath = "assets/image/logo.png";
//   return SvgPicture.asset(
//     iconPath,
//   );
// }

// Widget padded(Widget widget) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25),
//       child: widget,
//     );
//   }

// Widget icon() {
//   String iconPath = "assets/icons/app_icon.svg";
//   return SvgPicture.asset(
//     iconPath,
//     width: 48,
//     height: 56,
//   );
// }
