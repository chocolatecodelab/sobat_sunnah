import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sunnah_reminder/bottom_bar.dart';
import 'package:sunnah_reminder/register.dart';
import 'package:sunnah_reminder/reminder/reminder_view.dart';

class WelcomeScreen extends StatelessWidget {
  final String imagePath = "./assets/image/welcome.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(0, 116, 206, 164),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                icon(),
                const SizedBox(
                  height: 20,
                ),
                welcomeTextWidget(),
                const SizedBox(
                  height: 10,
                ),
                sloganText(),
                const SizedBox(
                  height: 40,
                ),
                getButton(context),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ));
  }

  Widget icon() {
    String iconPath = "assets/icons/app_icon.svg";
    return SvgPicture.asset(
      iconPath,
      width: 48,
      height: 56,
    );
  }

  Widget welcomeTextWidget() {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "WELCOME TO",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "SOBAT SUNNAH",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }

  Widget sloganText() {
    return Text(
      "Hidupkan Sunnah Rasulullah SAW",
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.9)),
    );
  }

  Widget getButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(const RegisterPage());
      },
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        // backgroundColor: const Color(0xFF408840),
        textStyle: TextStyle(
          color: Colors.white,
          fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(vertical: 24),
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Center(
            child: Text(
              "Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return const ReminderView(
          title: "Sobat Sunnah",
        );
      },
    ));
  }
}
