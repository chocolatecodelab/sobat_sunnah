import 'dart:ffi';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunnah_reminder/controller.dart';
import 'package:sunnah_reminder/splash/welcome_screen.dart';

import './level_system.dart';
import 'package:flutter/material.dart';
import 'model/tb_transaksi_sunnah_helper.dart';

class ProfilPage extends StatefulWidget {
  final GetStorage? box;
  const ProfilPage({super.key, this.box});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  var auth = Get.put(Controller());
  List<Map<String, String>> cardData = [];
  int completedTasks = 0;
  int completedDays = 0;
  LevelSystem levelSystem = LevelSystem();
  String getTitleForLevel(int level) {
    if (level <= 1) {
      return "Awal Hijrah";
    } else if (level <= 5) {
      return "Mengejar Istiqomah";
    } else if (level <= 10) {
      return "Pengelana Sunnah";
    } else if (level <= 15) {
      return "Ummat";
    } else {
      return "Ahlussunnah";
    }
  }

  void _dayDone() async {
    final dayCompleted = await SQLHelperTransaksi.countCompletedDays();
    setState(() {
      completedDays = dayCompleted;
      cardData = [
        {
          'textTop': levelSystem.totalExp.toString(),
          'textBottom': 'Total EXP',
        },
        {
          'textTop': completedDays.toString(),
          'textBottom': 'Runtutan Hari',
        },
      ];
    });
  }

  void _refreshLevel() async {
    final dataCompleted = await SQLHelperTransaksi.getItemsIsCompleted();
    setState(() {
      completedTasks = dataCompleted;
      levelSystem.updateLevel(completedTasks * 100);
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshLevel();
    _dayDone();
  }

  @override
  Widget build(BuildContext context) {
    final String username = widget.box!.read("username");
    final String jenisKelamin = widget.box!.read("jenis_kelamin");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey,
        elevation: 2,
        title: Text(
          "Profil",
          style: const TextStyle(
            color: Color(0xFF41966F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.white54,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                jenisKelamin == "Laki-laki"
                    ? SvgPicture.asset(
                        "assets/image/male_avatar.svg",
                        height: 96,
                      )
                    : Image.asset(
                        "assets/images/muslimah_avatar.png",
                        height: 96,
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(getTitleForLevel(levelSystem.currentLevel))],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Level ${levelSystem.currentLevel}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
                '${levelSystem.expNeededForNextLevel - levelSystem.currentExp} Points menuju level berikutnya'),
            const SizedBox(height: 10),
            SizedBox(
              height: 10, // Atur tinggi progress bar
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30), // Atur padding kanan dan kiri di sini
                child: LinearProgressIndicator(
                  value: levelSystem.currentExp /
                      levelSystem.expNeededForNextLevel,
                  backgroundColor: Colors.grey,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(10.0)), // Mengatur radius sudut ujung
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Divider(
              height: 1,
              thickness: 3,
            ),
            SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left:
                          16.0), // Atur nilai padding kiri sesuai kebutuhan Anda
                  child: Text(
                    'Statistik',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0), // Sesuaikan sesuai kebutuhan
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 3.0,
                  children: List.generate(cardData.length, (index) {
                    final textTop =
                        cardData[index]['textTop'] ?? 'Default Top Text';
                    final textBottom =
                        cardData[index]['textBottom'] ?? 'Default Bottom Text';
                    return CardWidget(
                      icon: Icons.flash_on,
                      textTop: textTop,
                      textBottom: textBottom,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final IconData icon;
  final String textTop;
  final String textBottom;

  const CardWidget({
    required this.icon,
    required this.textTop,
    required this.textBottom,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0), // Menambahkan padding ke card
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 32,
                color: const Color(0xFF41966F)), // Mengurangi ukuran ikon
            Text(
              textTop,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold), // Mengurangi ukuran teks atas
            ),
            Text(
              textBottom,
              style:
                  const TextStyle(fontSize: 12), // Mengurangi ukuran teks bawah
            ),
          ],
        ),
      ),
    );
  }
}
