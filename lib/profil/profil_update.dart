import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunnah_reminder/controller.dart';
import 'package:sunnah_reminder/splash/welcome_screen.dart';

class ProfilUpdate extends StatefulWidget {
  const ProfilUpdate({super.key});

  @override
  State<ProfilUpdate> createState() => _ProfilUpdateState();
}

class _ProfilUpdateState extends State<ProfilUpdate> {
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
