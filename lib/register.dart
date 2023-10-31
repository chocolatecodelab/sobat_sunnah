import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sunnah_reminder/bottom_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sunnah_reminder/controller.dart';
import 'package:sunnah_reminder/splash/welcome_screen.dart';
import 'package:sunnah_reminder/widget/confirmation_dialog_konfirmasi.dart';
import 'package:sunnah_reminder/widget/success_confirmation_dialog.dart';

class RegisterPage extends StatefulWidget {
  static const String id = "login_page";

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _signInGlobalKey = GlobalKey<FormState>();
  bool passwordSee = true;
  var auth = Get.put(Controller());
  String selectedValue = 'Laki-laki';

  @override
  Widget build(BuildContext context) {
    // final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(30), // Atur radius sudut kiri bawah
                  // bottomRight: Radius.circular(30), // Atur radius sudut kanan bawah
                  ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Sobat Sunnah',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          reverse: true,
          // Menggunakan SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset(
                  "assets/image/notifikasi.svg",
                  width: 250,
                  height: 250,
                ),
                const Center(
                  child: Text(
                    "Selamat Datang!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                const Center(
                  child: Text(
                    "Silahkan isi data ini terlebih dahulu.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(height: 10),
                // Text(
                //   'atau',
                //   style: TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //     color: Colors.black,
                //   ),
                // ),
                SizedBox(height: 0),
                Form(
                  key: _signInGlobalKey,
                  autovalidateMode: AutovalidateMode
                      .always, // Ini akan otomatis memeriksa validasi setiap saat
                  child: Column(
                    children: [
                      TextFormField(
                        controller: auth.username,
                        decoration: const InputDecoration(
                          hintText: "Username",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username wajib diisi'; // Pesan error jika input kosong
                          } else if (value.length < 6) {
                            return 'Username minimal harus terdiri dari 6 karakter'; // Pesan error jika username kurang dari 6 karakter
                          }
                          return null; // Validasi berhasil
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 400,
                        child: DropdownButtonFormField<String>(
                          value: selectedValue,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: ['Laki-laki', 'Perempuan']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Pilih jenis kelamin',
                            border: OutlineInputBorder(),
                          ),
                          isDense: true,
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF41966F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_signInGlobalKey.currentState!.validate()) {
                        // Tombol hanya akan berfungsi jika validasi berhasil
                        bool? confirmationResult = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ConfirmationDialogKonfirmasi(
                                message:
                                    "Apakah anda yakin ingin menyimpan perubahan?");
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
                          await auth.box.write("username", auth.username.text);
                          await Get.offAll(BottomBar(
                            username: auth.box,
                            indexDirect: 0,
                          ));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
