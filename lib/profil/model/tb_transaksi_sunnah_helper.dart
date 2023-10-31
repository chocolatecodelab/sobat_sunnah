import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperTransaksi {
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

  static Future<int> createTransaksiSunnah(
      int userId, int sunnahId, int isCompleted) async {
    final db = await SQLHelperTransaksi.db();

    final data = {
      'user_id': userId,
      'sunnah_id': sunnahId,
      'isCompleted': isCompleted,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    final id = await db.insert('tb_transaksi_sunnah', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // static Future<List<Map<String, dynamic>>> getItemsByDay(DateTime hari) async {
  //   final db = await SQLHelperTransaksi.db();
  //   String tanggalString = hari.toLocal().toIso8601String();
  //   String tanggalHanya = tanggalString.split('T')[0];
  //   return db.rawQuery('''
  //     SELECT tb_transaksi_sunnah.*, tb_sunnah.judul, tb_sunnah.arabic, tb_sunnah.latin, tb_sunnah.terjemahan, tb_sunnah.manfaat, tb_sunnah.deskripsi, tb_sunnah.waktu_pelaksanaan, tb_sunnah.isHari, tb_jenis_sunnah.nama_jenis_sunnah
  //     FROM tb_transaksi_sunnah
  //     INNER JOIN tb_sunnah ON tb_transaksi_sunnah.sunnah_id = tb_sunnah.id_sunnah
  //     INNER JOIN tb_jenis_sunnah ON tb_sunnah.jenis_id = tb_jenis_sunnah.id_jenis_sunnah
  //     WHERE DATE(tb_transaksi_sunnah.tanggal_pelaksanaan) = '$tanggalHanya';
  // ''');
  // }

  static Future<List<Map<String, dynamic>>> getItemsByDayIsNotCompleted(
      DateTime hari) async {
    final db = await SQLHelperTransaksi.db();
    String tanggalString = hari.toLocal().toIso8601String();
    String tanggalHanya = tanggalString.split('T')[0];
    return db.rawQuery(
        '''
      SELECT tb_transaksi_sunnah.*, tb_sunnah.judul, tb_sunnah.arabic, tb_sunnah.latin, tb_sunnah.terjemahan, tb_sunnah.manfaat, tb_sunnah.deskripsi, tb_sunnah.waktu_pelaksanaan, tb_sunnah.isHari, tb_jenis_sunnah.nama_jenis_sunnah
      FROM tb_transaksi_sunnah
      INNER JOIN tb_sunnah ON tb_transaksi_sunnah.sunnah_id = tb_sunnah.id_sunnah
      INNER JOIN tb_jenis_sunnah ON tb_sunnah.jenis_id = tb_jenis_sunnah.id_jenis_sunnah
      WHERE DATE(tb_transaksi_sunnah.tanggal_pelaksanaan) = '$tanggalHanya'
      AND tb_transaksi_sunnah.isCompleted = 0;
  ''');
  }

  static Future<List<Map<String, dynamic>>> getItemsDayIsCompleted(
      DateTime hari) async {
    final db = await SQLHelperTransaksi.db();
    String tanggalString = hari.toLocal().toIso8601String();
    String tanggalHanya = tanggalString.split('T')[0];
    return db.rawQuery(
        '''
      SELECT tb_transaksi_sunnah.*, tb_sunnah.judul, tb_sunnah.arabic, tb_sunnah.latin, tb_sunnah.terjemahan, tb_sunnah.manfaat, tb_sunnah.deskripsi, tb_sunnah.waktu_pelaksanaan, tb_sunnah.isHari, tb_jenis_sunnah.nama_jenis_sunnah
      FROM tb_transaksi_sunnah
      INNER JOIN tb_sunnah ON tb_transaksi_sunnah.sunnah_id = tb_sunnah.id_sunnah
      INNER JOIN tb_jenis_sunnah ON tb_sunnah.jenis_id = tb_jenis_sunnah.id_jenis_sunnah
      WHERE DATE(tb_transaksi_sunnah.tanggal_pelaksanaan) = '$tanggalHanya'
      AND tb_transaksi_sunnah.isCompleted = 1;
  ''');
  }

  // static Future<List<Map<String, dynamic>>> getItemWithJenisSunnah(int id) async {
  //   final db = await SQLHelperTransaksi.db();
  //   return db.rawQuery('''
  //   SELECT tb_transaksi_sunnah.*, tb_sunnah.judul, tb_sunnah.arabic, tb_sunnah.latin, tb_sunnah.terjemahan, tb_sunnah.manfaat, tb_sunnah.deskripsi, tb_sunnah.tanggal_pelaksanaan, tb_sunnah.waktu_pelaksanaan, tb_jenis_sunnah.nama_jenis_sunnah
  //   FROM tb_transaksi_sunnah
  //   INNER JOIN tb_sunnah ON tb_transaksi_sunnah.sunnah_id = tb_sunnah.id_sunnah
  //   INNER JOIN tb_jenis_sunnah ON tb_sunnah.jenis_id = tb_jenis_sunnah.id_jenis_sunnah;
  //   WHERE tb_transaksi_sunnah.id = $id
  // ''');
  // }

  static Future<int> updateTransaksi(int id) async {
    final db = await SQLHelperTransaksi.db();

    final data = {
      'isCompleted': 1,
    };

    final result = await db.update('tb_transaksi_sunnah', data,
        where: "id_transaksi_sunnah = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> deleteTransaksi(int id) async {
    final db = await SQLHelperTransaksi.db();
    return db.delete('tb_transaksi_sunnah',
        where: "id_transaksi_sunnah = ?", whereArgs: [id]);
  }

  static Future<int> getItemsIsCompleted() async {
    final db = await SQLHelperTransaksi.db();
    final result = await db.rawQuery(
        '''
    SELECT COUNT(*) AS count
    FROM tb_transaksi_sunnah
    INNER JOIN tb_sunnah ON tb_transaksi_sunnah.sunnah_id = tb_sunnah.id_sunnah
    INNER JOIN tb_jenis_sunnah ON tb_sunnah.jenis_id = tb_jenis_sunnah.id_jenis_sunnah
    WHERE tb_transaksi_sunnah.isCompleted = 1;
  ''');
    return sql.Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<int> countCompletedDays() async {
    final db = await SQLHelperTransaksi.db();
    final result = await db.rawQuery(
        '''
    SELECT COUNT(DISTINCT DATE(tanggal_pelaksanaan)) as total_hari_selesai
    FROM tb_transaksi_sunnah
    WHERE isCompleted = 1;
  ''');

    if (result.isNotEmpty) {
      return result.first['total_hari_selesai'] as int;
    } else {
      return 0;
    }
  }
}
