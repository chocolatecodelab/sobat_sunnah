import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunnah_reminder/bacaan_sholat/model/model_niat.dart';
import 'package:sunnah_reminder/bacaan_sholat/page/sunnah_page.dart';
import 'package:sunnah_reminder/bottom_bar.dart';
import 'package:sunnah_reminder/challenge/challenge_sunnah.dart';
import 'package:sunnah_reminder/challenge/model/tb_transaksi_sunnah_helper.dart';
import 'package:sunnah_reminder/controller.dart';
import 'package:sunnah_reminder/widget/popup_tantangan.dart';
import 'package:sunnah_reminder/widget/success_confirmation_dialog.dart';

import '../challenge/model/tb_transaksi_sunnah_helper.dart';

class DashboardPage extends StatefulWidget {
  final GetStorage? box;
  const DashboardPage({super.key, this.box});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Section untuk tambahTantangan
  void tambahTantangan(int jenis_id) async {
    // Sesuaikan Jenis_idnya kalo mau all in one berarti panggil 3x.
    // Jenis ID Sunnah : 1 = Sholat , 2 = Puasa , 3 = Lain-lain
    await SQLHelperTransaksi.tambahTantangan(DateTime.now(), jenis_id);
  }

  void tambahTantanganALlinOne() {
    tambahTantangan(1);
    tambahTantangan(2);
    tambahTantangan(3);
}

  void tambahTantanganSholat() {
    tambahTantangan(1);
  }

  void tambahTantanganPuasa() {
    tambahTantangan(2);
  }

  void tambahTantanganLainnya() {
    tambahTantangan(3);
  }

  var auth = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    final String username = widget.box!.read("username");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey,
        elevation: 2,
        title: const Text(
          'Dashboard',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF41966F)),
        ),
      ),
      body: ListView(
        children: [
          // ElevatedButton(
          //   onPressed: () async {
          //     await NotificationController.createNewNotification(
          //         title: "Sholat Tahajud",
          //         body: "Ayo Sholat Tahajud malam ini");
          //   },
          //   style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color(
          //           0xFF41966F), // Hapus warna latar belakang tombol
          //       foregroundColor: Colors.white, // Warna teks tombol
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       elevation: 4),
          //   child: const Text('Mulai'),
          // ),
          // Welcome User
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text("Selamat datang, $username!",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.waving_hand, color: Colors.yellow)
              ],
            ),
          ),
          roundedRectangleTile(
            title: 'Yuk Lanjutkan Sunnah Harianmu!',
            subtitle: 'Tap untuk lebih lanjut',
            onTap: () {
              Get.to(ChallengePage(title: "Challenge Sunnah"));
            },
          ),

          // Horizontal Slider 1 (Upcoming Event)
          getItemSlider("Acara Mendatang", [
            // Item 1
            getItemCardEvent(
              "Puasa Ayyamul Bidh",
              "Puasa dipertengahan bulan, berlatih mengontrol hawa nafsu",
              "./assets/image/ayyamul_bidh.jpg",
              1,
            ),
            // Item 2
            getItemCardEvent(
              "Sholat Tarawih",
              "Sholat yang dapat menghapus dosa di masa lalu",
              "./assets/image/tarawih.jpg",
              2,
            ),
            // Item 3
            getItemCardEvent(
                "Al-Kahfi Time",
                "Membaca Surah Al-Kahfi tiap Jum'at, memancarkan pancaran cahaya pada hari kiamat",
                "./assets/image/kahfi.jpg",
                3),
          ]),

          // Horizontal Slider 2 (Challenge Today)
          getItemSlider("Tantangan Sunnah", [
            // Item 1
            getItemCard(
                "Sunnah All-in-One",
                "Harapan menjadi seorang yang menghidupkan sunnah Rasulullah dengan ganjaran pahala dan balasan yang luar biasa",
                "./assets/image/allone.jpg",
                "1. Puasa\n2. Sholat\n3. Sunnah Lainnya"),
            getItemCard(
                "Membaca Qur'an",
                "Harapan menjadi keluarga Al-Qur'an dengan sering membaca Al-Qur'an setiap hari",
                "./assets/image/quran.jpg",
                "1. Surah Al-Mulk\n 2. Surah Yasin \n3. Surah Al-Waqi'ah"),
            // Item 2
            getItemCard(
                "Sholat Sunnah",
                "Menjadi pemburu surga dengan menjalankan perintah sholat sunnah setiap saat",
                "./assets/image/shalat.jpg",
                "1. Sholat Rawatib\n2. Sholat Dhuha\n3. Sholat Tahajud"),
            // Item 3
            getItemCard(
                "Pejuang Puasa",
                "Menjadi seorang Ummat dengan penuh makna dengan menjalankan sunnah Puasa",
                "./assets/image/puasa.jpg",
                "1. Puasa Senin-Kamis\n 2. Puasa Ayyamul Bidh \n3. Puasa 10 Muharram"),
          ]),
        ],
      ),
    );
  }

  Widget getItemSlider(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF41966F),
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 300, // Set the desired height for the horizontal slider
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: items,
          ),
        ),
      ],
    );
  }

  Widget getItemCard(
      String title, String subtitle, String backgroundImageUrl, String list) {
    return Container(
      width: 250, // Set the desired width for each item card
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: 5, // Tambahkan bayangan kartu
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(backgroundImageUrl), // URL gambar latar belakang
                fit: BoxFit.cover, // Sesuaikan gambar dengan ukuran card
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black, // Warna bayangan
                            offset: Offset(1, 1), // Posisi bayangan (X, Y)
                            blurRadius: 3, // Radius blur bayangan
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        shadows: [
                          Shadow(
                            color: Colors.black, // Warna bayangan
                            offset: Offset(1, 1), // Posisi bayangan (X, Y)
                            blurRadius: 3, // Radius blur bayangan
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool? confirmationResult = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PopupTantangan(
                            title: title,
                            message: subtitle,
                            list: list,
                          );
                        },
                      );
                      if (confirmationResult == true) {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessConfirmationDialog(
                                  message: "Data berhasil disimpan",
                                  icon: Icons.check_circle_outline);
                            });

                        // Pakai if disini
                        tambahTantanganALlinOne();
                        await auth.box.write("username", auth.username.text);
                        await Get.off(BottomBar(
                          username: auth.box,
                          indexDirect: 2,
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF41966F), // Hapus warna latar belakang tombol
                        foregroundColor: Colors.white, // Warna teks tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(double.infinity, 40),
                        elevation: 4),
                    child: Text('Mulai'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getItemCardEvent(
      String title, String subtitle, String backgroundImageUrl, int item) {
    return Container(
      width: 250, // Set the desired width for each item card
      margin: EdgeInsets.all(8),
      child: Card(
        elevation: 5, // Tambahkan bayangan kartu
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(backgroundImageUrl), // URL gambar latar belakang
                fit: BoxFit.cover, // Sesuaikan gambar dengan ukuran card
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black, // Warna bayangan
                            offset: Offset(1, 1), // Posisi bayangan (X, Y)
                            blurRadius: 3, // Radius blur bayangan
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        shadows: [
                          Shadow(
                            color: Colors.black, // Warna bayangan
                            offset: Offset(1, 1), // Posisi bayangan (X, Y)
                            blurRadius: 3, // Radius blur bayangan
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final modelNiatList = [
                        ModelNiat.fromJson({
                          "id": 1,
                          "judul": "Puasa Ayyamul Bidh",
                          "image": "assets/images/prayer.png",

                          "arabic":
                              "صُوْمُ ثَلاَثَةِ اَیّٰامٍ مِّنْ كُلِّ شَهْرٍ وَّصِیْا مِّا یُّتْرَكُ سِوٰۤآءُ اُوْسَطِ وَاخِرِ سِتٰۤئِیْنَ مِنْ شَهْرِ ذُیْ الْحِجَّةِ",
                          "latin":
                              "Ṣūmu thalāthati ayyāmin min kulli shaharin waṣiyyā mā yutraku siwāu uṣaṭi wa-akhiri sittīna min shahri dhūl-ḥijjah",
                          "terjemahan":
                              "Puasa tiga hari setiap bulan dan puasa Ayyam al-Beed (13, 14, 15) adalah puasa yang disyariatkan. Kecuali puasa yang digantikan pada hari itu (yakni puasa tasyrik yang disunatkan)",
                          "deskripsi":
                              "Puasa pada tanggal 13, 14, dan 15 setiap bulan hijriah (kalender Islam) adalah sunnah yang dianjurkan. Ini juga dianjurkan berdasarkan hadis.",
                          "manfaat":
                              "Puasa pertengahan bulan memiliki manfaat spiritual, seperti mendekatkan diri kepada Allah dan meningkatkan keimanan.",
                          "jadwal":
                              " Tanggal 13, 14, dan 15 kecuali pada hari tasyrik yaitu 13 Dzulhijjah."
                          // Informasi lainnya
                        }),
                        ModelNiat.fromJson({
                          "id": 2,
                          "judul": "Sholat Tarawih",
                          "image": "assets/images/prayer2.png",
                          "deskripsi":
                              "shalat tarawih adalah ibadah sholat yagng hanya bisa dikerjakan saat bulan Ramadhan",
                          "arabic":
                              "مَنْ قَامَ رَمَضَانَ إيمَانًا وَاحْتِسَابًا غُفِرَ لَهُ مَا تَقَدَّمَ مِنْ ذَنْبِهِ",
                          "latin":
                              "Man qara'a suurat al-Kahfi fee yawmi al-Jumu'ati adhaa lahu min an-Nuuri ma bayna al-Jumu'atayn.",
                          "terjemahan":
                              "Barangsiapa ibadah (tarawih) di bulan Ramadhan seraya beriman dan ikhlas, maka diampuni baginya dosa yang telah lampau (HR al-Bukhari, Muslim, dan lainnya).",
                          "jadwal":
                              "setiap hari setelah isya pada bulan ramadhan"
                        }),
                        ModelNiat.fromJson({
                          "id": 3,
                          "judul": "Surah Al-Kahfi",
                          "image": "assets/images/prayer3.png",
                          "deskripsi":
                              "Surah Al-Kahfi adalah surah ke-18 dalam Al-Qur'an. Surah ini mengandung pelajaran tentang iman, cobaan, dan perlindungan dari fitnah Dajjal.",
                          "arabic":
                              "مَنْ قَرَأَ سُورَةَ الْكَهْفِ فِى يَوْمِ الْجُمُعَةِ أَضَاءَ لَهُ مِنَ النُّورِ مَا بَيْنَ الْجُمُعَتَيْنِ",
                          "latin":
                              "Man qara'a suurat al-Kahfi fee yawmi al-Jumu'ati adhaa lahu min an-Nuuri ma bayna al-Jumu'atayn.",
                          "terjemahan":
                              "Barangsiapa yang membaca surat Al Kahfi pada hari Jum'at, dia akan disinari cahaya di antara dua Jum'at.(HR. An Nasa'i dan Baihaqi. Syaikh Al Albani mengatakan bahwa hadits ini shahih sebagaimana dalam Shohihul Jami'.)",
                          "manfaat":
                              "Memberikan cahaya dan perlindungan dari Dajjal.",
                          "jadwal":
                              "membaca surah Al-Kahfi pada malam Jumat dan hari Jumat"
                        }),
                        // Tambahkan item-model lainnya di sini
                      ];

                      Get.to(SunnahPage(niatData: modelNiatList[item - 1]));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF41966F), // Hapus warna latar belakang tombol
                        foregroundColor: Colors.white, // Warna teks tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(double.infinity, 40),
                        elevation: 4),
                    child: Text("Pelajari lebih lanjut"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget roundedRectangleTile({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 100,
      child: Card(
        color: const Color(0xFF41966F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Mengatur sudut bulat
        ),
        margin: EdgeInsets.only(left: 20, right: 20),
        elevation: 4, // Mengatur bayangan
        child: Center(
          child: ListTile(
            title: Text(title,
                style: TextStyle(fontSize: 14, color: Colors.white)),
            subtitle: Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            iconColor: Colors.white,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
