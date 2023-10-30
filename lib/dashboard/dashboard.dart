import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunnah_reminder/notification/notification_controller.dart';
import 'package:sunnah_reminder/register.dart';
import 'package:sunnah_reminder/splash/welcome_screen.dart';

class DashboardPage extends StatefulWidget {
  final GetStorage? box;
  const DashboardPage({super.key, this.box});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
              // Handle when the tile is clicked
            },
          ),

          // Horizontal Slider 1 (Upcoming Event)
          getItemSlider("Acara Mendatang", [
            // Item 1
            getItemCardEvent(
              "Puasa Ayyamul Bidh",
              "Puasa dipertengahan bulan, berlatih mengontrol hawa nafsu",
              "./assets/image/ayyamul_bidh.jpg",
            ),
            // Item 2
            getItemCardEvent(
              "Sholat Tarawih",
              "Sholat yang dapat menghapus dosa di masa lalu",
              "./assets/image/tarawih.jpg",
            ),
            // Item 3
            getItemCardEvent(
              "Al-Kahfi Time",
              "Membaca Surah Al-Kahfi tiap Jum'at, memancarkan pancaran cahaya pada hari kiamat",
              "./assets/image/kahfi.jpg",
            ),
          ]),

          // Horizontal Slider 2 (Challenge Today)
          getItemSlider("Tantangan Sunnah", [
            // Item 1
            getItemCard(
                "Membaca Qur'an",
                "Harapan menjadi keluarga Al-Qur'an dengan sering membaca Al-Qur'an setiap hari",
                "./assets/image/quran.jpg"),
            // Item 2
            getItemCard(
                "Sholat Sunnah",
                "Menjadi pemburu surga dengan menjalankan perintah sholat sunnah setiap saat",
                "./assets/image/shalat.jpg"),
            // Item 3
            getItemCard(
                "Pejuang Puasa",
                "Menjadi seorang Ummat dengan penuh makna dengan menjalankan sunnah Puasa",
                "./assets/image/puasa.jpg"),
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

  Widget getItemCard(String title, String subtitle, String backgroundImageUrl) {
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
                    onPressed: () {
                      // Handle button action here
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
      String title, String subtitle, String backgroundImageUrl) {
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
                      // Handle button action here
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
