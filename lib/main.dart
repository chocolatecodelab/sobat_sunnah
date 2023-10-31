import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunnah_reminder/bottom_bar.dart';
import 'package:sunnah_reminder/notification/notification_controller.dart';
import 'package:sunnah_reminder/splash/splash.dart';

import 'challenge/model/tb_jenis_sunnah_helper.dart';
import 'challenge/model/tb_transaksi_sunnah_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  await NotificationController.scheduleSholatNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _setDatabase() async {
    await SQLHelperJenis.getJenisSunnah();
  }

  // This widget is the root of your application.
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
    _setDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 116, 206, 164)),
          useMaterial3: true,
          fontFamily: 'Poppins'),
      navigatorKey: MyApp.navigatorKey,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
