import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupTantangan extends StatefulWidget {
  final String title;
  final String message;
  final String list;

  PopupTantangan(
      {required this.title, required this.message, required this.list});

  @override
  _PopupTantanganState createState() => _PopupTantanganState();
}

class _PopupTantanganState extends State<PopupTantangan> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(10, 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Colors.black,
                    )),
              ],
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Image.asset("./assets/images/prayer2.png"),
            SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  'Deskripsi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.message),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'List Sunnah',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.list,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 45),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Color(0xFF41966F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Mulai',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
