import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:sunnah_reminder/bacaan_sholat/page/sunnah_page.dart';
import 'package:sunnah_reminder/bacaan_sholat/model/model_niat.dart'; // Menggunakan ModelNiat

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<ModelNiat>> futureData; // Menggunakan ModelNiat

  @override
  void initState() {
    super.initState();
    futureData = readJsonData();
  }

  Future<List<ModelNiat>> readJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/data/sunnah_data.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list
        .map((e) => ModelNiat.fromJson(e))
        .toList(); // Menggunakan ModelNiat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'List Sunnah',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF41966F)),
        ),
        shadowColor: Colors.grey,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                FutureBuilder(
                  future: futureData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      var items = snapshot.data
                          as List<ModelNiat>; // Menggunakan ModelNiat
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SunnahPage(
                                        niatData: items[
                                            index]), // Menggunakan items[index] sebagai ModelNiat
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          "assets/images/ic_bacaan.png"),
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      items[index].judul,
                                      textAlign: TextAlign
                                          .center, // Menggunakan items[index].judul sebagai judul
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
