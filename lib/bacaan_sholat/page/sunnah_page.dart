import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunnah_reminder/bacaan_sholat/model/model_niat.dart';

class SunnahPage extends StatefulWidget {
  final ModelNiat niatData;
  SunnahPage({required this.niatData});

  @override
  SunnahPageState createState() => SunnahPageState();
}

class SunnahPageState extends State<SunnahPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Sunnah",
            style: TextStyle(
                color: Color(0xFF41966F), fontWeight: FontWeight.bold),
          )),
      backgroundColor: Colors.white, // Mengganti warna background
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.white, // Warna latar belakang
                  borderRadius: BorderRadius.circular(
                      12.0), // Border radius yang membulatkan sudut
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Warna bayangan
                      spreadRadius: 3, // Sebaran bayangan
                      blurRadius: 7, // Jumlah blur
                      offset: Offset(0, 3), // Offset dari bayangan (x, y)
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.niatData.judul,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset(widget.niatData.image),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Deskripsi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ]),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          child: SelectableText(
                            widget.niatData.deskripsi,
                            style: const TextStyle(
                              color: Colors.black, // Mengganti warna font
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: SelectableText(
                            widget.niatData.arabic,
                            style: const TextStyle(
                              color: Colors.black, // Mengganti warna font
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        // Center(
                        //   child: Text(
                        //     widget.niatData.latin,
                        //     style: TextStyle(
                        //       color: Colors.black, // Mengganti warna font
                        //       fontSize: 12,
                        //       fontStyle: FontStyle.italic,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: SelectableText(
                            widget.niatData.terjemahan,
                            style: TextStyle(
                              color: Colors.black, // Mengganti warna font
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Jadwal",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.watch_later_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text(widget.niatData.jadwal))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right: 16), // Margin di sebelah kanan tombol
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(
                                      5.0), // Tinggi bayangan
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      const Color.fromARGB(255, 219, 219,
                                          219)), // Warna bayangan
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(Colors
                                          .transparent), // Warna saat ditekan
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(const Color(
                                          0xFF41966F)), // Atur warna latar belakang di sini
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Atur radius sudut di sini
                                    ),
                                  ),

                                  minimumSize: MaterialStateProperty.all(Size(
                                      150, 40)), // Atur lebar dan tinggi tombol
                                ),
                                child: Text(
                                  "Kembali",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
