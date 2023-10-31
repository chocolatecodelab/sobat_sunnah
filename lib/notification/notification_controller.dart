import 'package:sunnah_reminder/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/notification_icon', //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple),
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  // static ReceivePort? receivePort;
  // static Future<void> initializeIsolateReceivePort() async {
  //   receivePort = ReceivePort('Notification action port in main isolate')
  //     ..listen(
  //         (silentData) => onActionReceivedImplementationMethod(silentData));

  //   // This initialization only happens on main isolate
  //   IsolateNameServer.registerPortWithName(
  //       receivePort!.sendPort, 'notification_action_port');
  // }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    } else {
      // this process is only necessary when you need to redirect the user
      // to a new page or use a valid context, since parallel isolates do not
      // have valid context, so you need redirect the execution to main isolate
      // if (receivePort == null) {
      //   print(
      //       'onActionReceivedMethod was called inside a parallel dart isolate.');
      //   SendPort? sendPort =
      //       IsolateNameServer.lookupPortByName('notification_action_port');

      //   if (sendPort != null) {
      //     print('Redirecting the execution to main isolate process.');
      //     sendPort.send(receivedAction);
      //     return;
      //   }
      // }

      // return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  // static Future<void> onActionReceivedImplementationMethod(
  //     ReceivedAction receivedAction) async {
  //   MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
  //       '/notification-page',
  //       (route) =>
  //           (route.settings.name != '/notification-page') || route.isFirst,
  //       arguments: receivedAction);
  // }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Tambahkan Notifikasi!',
                style: Theme.of(context).textTheme.titleLarge),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: Icon(Icons.notifications_active_outlined)),
                  ],
                ),
                SizedBox(height: 20),
                Text('Aktifkan Notifikasi untuk menunjang pengingat Sunnah!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Tolak',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Aktifkan',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     BACKGROUND TASKS TEST
  ///  *********************************************
  static Future<void> executeLongTaskInBackground() async {
    // print("starting long task");
    // await Future.delayed(const Duration(seconds: 4));
    // final url = Uri.parse("http://google.com");
    // final re = await http.get(url);
    // print(re.body);
    // print("long task done");
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> createNewNotification({
    required String title,
    required String body,
  }) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .remainder(100000), // -1 is replaced by a random number
          channelKey: 'alerts',
          title: title,
          body: body,
          bigPicture: 'assets/images/prayer2.png',
          largeIcon: 'assets/images/prayer2.png',
          //'asset://assets/images/balloons-in-sky.jpg',
          notificationLayout: NotificationLayout.BigPicture,
          payload: {'notificationId': '1234567890'}),
    );
  }

  static Future<void> scheduleSholatNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;
    // Jadwal Sholat Rawatib Zhuhur

    await scheduleSholatIed(
        title: "Sholat Idul Fitri",
        body: "Jangan lupa sholat Idul Fitrinya ya!",
        month: 10,
        day: 1,
        hour: 7,
        minute: 0);

    await scheduleSholatIed(
        title: "Sholat Idul Adha",
        body: "Jangan lupa sholat Idul Adhanya ya!",
        month: 12,
        day: 10,
        hour: 7,
        minute: 0);

    await scheduleSholatSunnahHarian(
        title: "Sholat Tahajud",
        body: "Jangan lupa sholat Tahajudnya ya!",
        hour: 1,
        minute: 0);
    await scheduleSholatSunnahHarian(
        title: "Sholat Isyraq (Fajar)",
        body: "Jangan lupa sholat Isyraq (Fajar)nya ya!",
        hour: 6,
        minute: 0);
    await scheduleSholatSunnahHarian(
        title: "Sholat Dhuha",
        body: "Jangan lupa sholat Dhuhanya ya!",
        hour: 9,
        minute: 0);
    await scheduleSholatSunnahHarian(
        title: "Sholat Rawatib Zhuhur",
        body: "Jangan lupa sholat rawatib Zhuhurnya ya!",
        hour: 12,
        minute: 0);

    // Jadwal Sholat Rawatib Ashar
    await scheduleSholatSunnahHarian(
        title: 'Sholat Rawatib Ashar',
        body: "Jangan lupa sholat rawatib Asharnya ya!",
        hour: 15,
        minute: 0);

    // // Jadwal Sholat Rawatib Maghrib
    await scheduleSholatSunnahHarian(
        title: 'Sholat Rawatib Maghrib',
        body: "Jangan lupa sholat rawatib Maghribnya ya!",
        hour: 18,
        minute: 0);

    // Jadwal Sholat Rawatib Isya
    await scheduleSholatSunnahHarian(
        title: 'Sholat Rawatib Isya',
        body: "Jangan lupa sholat rawatib Isyanya ya!",
        hour: 20,
        minute: 0);

    // Jadwal Sholat Rawatib Shubuh
    await scheduleSholatSunnahHarian(
        title: 'Sholat Rawatib Shubuh',
        body: "Jangan lupa sholat rawatib Shubuhnya ya!",
        hour: 4,
        minute: 30);
  }

  static Future<void> schedulePuasaNotification(
      {required String title,
      required String body,
      required int hour,
      required int minute}) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;
    // Jadwal Sholat Rawatib Zhuhur
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}

Future<void> scheduleSholatSunnahHarian(
    {required String body,
    required String title,
    required int hour,
    required int minute}) async {
  DateTime scheduledTime = DateTime(
    DateTime.now().year, // Tahun saat ini
    DateTime.now().month, // Bulan saat ini
    DateTime.now().day, // Hari saat ini
    hour, // Jam
    minute, // Menit
  );
  // Pastikan waktu yang Anda tentukan adalah di masa depan
  if (scheduledTime.isBefore(DateTime.now())) {
    scheduledTime = scheduledTime.add(const Duration(days: 1)); // Tambah 1 hari
  }

  // Buat notifikasi
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: scheduledTime.millisecondsSinceEpoch.remainder(100000),
      channelKey: 'alerts', // Sesuaikan dengan channel yang telah Anda buat
      title: title,
      body: body,
      largeIcon:
          "https://github.com/chocolatecodelab/sobat_sunnah/blob/master/assets/image/logo.png?raw=true",
      bigPicture:
          'https://github.com/chocolatecodelab/sobat_sunnah/blob/master/assets/images/prayer4.png?raw=true', // Gantilah dengan URL gambar yang sesuai
      notificationLayout: NotificationLayout.BigPicture,
      payload: {'notificationId': title},
    ),
    schedule: NotificationCalendar(
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      millisecond: 0,
      weekday: null,
      allowWhileIdle: true,
    ),
  );
}

Future<void> scheduleSholatIed(
    {required String body,
    required String title,
    required int month,
    required int day,
    required int hour,
    required int minute}) async {
  HijriCalendar hijri = HijriCalendar.fromDate(
      DateTime(DateTime.now().year, month, day, hour, minute, 0));
  DateTime scheduledTime = DateTime(
    hijri.hYear,
    hijri.hMonth,
    hijri.hDay,
    hour, // Jam
    minute, // Menit
  );

  // Pastikan waktu yang Anda tentukan adalah di masa depan
  if (scheduledTime.isBefore(DateTime.now())) {
    scheduledTime = scheduledTime.add(const Duration(days: 1)); // Tambah 1 hari
  }

  // Buat notifikasi
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: scheduledTime.millisecondsSinceEpoch.remainder(100000),
      channelKey: 'alerts', // Sesuaikan dengan channel yang telah Anda buat
      title: title,
      body: body,
      bigPicture:
          'https://example.com/your_image.jpg', // Gantilah dengan URL gambar yang sesuai
      notificationLayout: NotificationLayout.BigPicture,
      payload: {'notificationId': title},
    ),
    schedule: NotificationCalendar(
      year: scheduledTime.year,
      month: scheduledTime.month,
      day: scheduledTime.day,
      hour: scheduledTime.hour,
      minute: scheduledTime.minute,
      second: 0,
      millisecond: 0,
      weekday: null,
      allowWhileIdle: true,
    ),
  );
}
