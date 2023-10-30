import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunnah_reminder/controller.dart';
import 'package:sunnah_reminder/splash/welcome_screen.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  var auth = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          auth.box.remove("username");
          Get.offAll(WelcomeScreen());
        },
        style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFF41966F), // Hapus warna latar belakang tombol
            foregroundColor: Colors.white, // Warna teks tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4),
        child: const Text('Mulai'),
      ),
    );
  }
}
