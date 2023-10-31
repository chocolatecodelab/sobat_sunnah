import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunnah_reminder/bacaan_sholat/page/main_page.dart';
import 'package:sunnah_reminder/bacaan_sholat/page/sunnah_page.dart';
import 'package:sunnah_reminder/challenge/challenge_sunnah.dart';
import 'package:sunnah_reminder/controller.dart';
import 'package:sunnah_reminder/dashboard/dashboard.dart';
import 'package:sunnah_reminder/profil/profil.dart';
import 'package:sunnah_reminder/reminder/reminder_view.dart';

class BottomBar extends StatefulWidget {
  final GetStorage username;
  final int indexDirect;
  const BottomBar({Key? key, required this.indexDirect, required this.username})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _currentIndex;
  late List<Widget> _pages = []; // Pindahkan inisialisasi ke sini
  var auth = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    final username = widget.username;
    if (widget.indexDirect == 2) {
      _currentIndex = 2;
    } else {
      _currentIndex = widget.indexDirect;
    }
    _pages = [
      if (username != null)
        DashboardPage(box: username)
      else
        const DashboardPage(),
      const ReminderView(title: "Sunnah Reminder"),
      const ChallengePage(title: "Challenge Sunnah"),
      const MainPage(),
      const ProfilPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: const Color(0xFF41966F),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Kalendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border_purple500_outlined),
              label: 'Challenge',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Sunnah',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profil',
            ),
          ],
          elevation: 5, // Atur elevasi untuk efek shadow
        ),
      ),
    );
  }
}
