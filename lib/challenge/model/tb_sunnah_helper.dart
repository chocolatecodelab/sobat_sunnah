import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperSunnah {
  static Future<void> createTables(sql.Database database) async {}

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbsobatsunnah.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createSunnah(
      String judul,
      String arabic,
      String latin,
      String terjemahan,
      String manfaat,
      int jenisId,
      String deskripsi,
      DateTime tanggalPelaksanaan,
      String waktuPelaksanaan,
      ) async {
    final db = await SQLHelperSunnah.db();

    final data = {
      'judul': judul,
      'arabic': arabic,
      'latin': latin,
      'terjemahan': terjemahan,
      'manfaat': manfaat,
      'jenis_id': jenisId,
      'deskripsi': deskripsi,
      'tanggal_pelaksanaan': tanggalPelaksanaan.toIso8601String(),
      'waktu_pelaksanaan': waktuPelaksanaan,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
    final id = await db.insert('tb_sunnah', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItemsWithJenisSunnah() async {
    final db = await SQLHelperSunnah.db();
    return db.rawQuery('''
    SELECT tb_sunnah.*, tb_jenis_sunnah.nama_jenis_sunnah
    FROM tb_sunnah
    INNER JOIN tb_jenis_sunnah ON tb_sunnah.jenis_id = tb_jenis_sunnah.id_jenis_sunnah;
  ''');
  }

  static Future<List<Map<String, dynamic>>> getItemWithJenisSunnah(
      int id) async {
    final db = await SQLHelperSunnah.db();
    return db.rawQuery('''
    SELECT tb_sunnah.*, tb_jenis_sunnah.nama_jenis_sunnah
    FROM tb_sunnah
    INNER JOIN tb_jenis_sunnah ON tb_sunnah.jenis_id = tb_jenis_sunnah.id_jenis_sunnah;
    WHERE tb_sunnah.id_sunnah = $id
  ''');
  }

  static Future<int> updateSunnah(
      int id,
      String judul,
      String arabic,
      String latin,
      String terjemahan,
      String manfaat,
      int jenisId,
      String deskripsi,
      DateTime tanggalPelaksanaan,
      String waktuPelaksanaan,
      ) async {
    final db = await SQLHelperSunnah.db();

    final data = {
      'judul': judul,
      'arabic': arabic,
      'latin': latin,
      'terjemahan': terjemahan,
      'manfaat': manfaat,
      'jenis_id': jenisId,
      'deskripsi': deskripsi,
      'tanggal_pelaksanaan': tanggalPelaksanaan.toIso8601String(),
      'waktu_pelaksanaan': waktuPelaksanaan,
      'updated_at': DateTime.now().toIso8601String(),
    };

    final result = await db
        .update('tb_sunnah', data, where: "id_sunnah = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> deleteSunnah(int id) async {
    final db = await SQLHelperSunnah.db();
    return db.delete('tb_sunnah', where: "id_sunnah = ?", whereArgs: [id]);
  }
}
