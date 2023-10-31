import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Controller extends GetxController {
  final box = GetStorage();
  late TextEditingController username;
  late TextEditingController jenisKelamin;

  @override
  void onInit() async {
    super.onInit();
    username = TextEditingController();
    jenisKelamin = TextEditingController();
  }
}
