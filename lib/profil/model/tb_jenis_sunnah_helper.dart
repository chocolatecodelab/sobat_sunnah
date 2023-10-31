
import 'dart:math';

import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperJenis {
  static Future<void> createTablesJenisSunnah(sql.Database database) async {
    await database.execute('''
    CREATE TABLE tb_jenis_sunnah (
      id_jenis_sunnah INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama_jenis_sunnah TEXT,
      created_at TIMESTAMP,
      updated_at TIMESTAMP
    )
    ''');

    await database.execute('''
    CREATE TABLE tb_sunnah (
      id_sunnah INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      judul TEXT,
      arabic TEXT,
      latin TEXT,
      terjemahan TEXT,
      manfaat TEXT,
      jenis_id INTEGER,
      deskripsi TEXT,
      tanggal_pelaksanaan TIMESTAMP,
      waktu_pelaksanaan TEXT,
      isHari VARCHAR,
      created_at TIMESTAMP,
      updated_at TIMESTAMP
    )
    ''');

    await database.execute('''
    CREATE TABLE tb_transaksi_sunnah (
    id_transaksi_sunnah INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_id INTEGER,
    sunnah_id INTEGER,
    isCompleted INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP, 
    tanggal_pelaksanaan TIMESTAMP
    );
    ''');

    await database.rawInsert('''
    INSERT INTO tb_jenis_sunnah (nama_jenis_sunnah, created_at, updated_at)
    VALUES (?, ?, ?),
           (?, ?, ?),
           (?, ?, ?)
''', [
      'Sholat',
      '2023-10-18 10:00:00',
      '2023-10-18 10:00:00',
      'Puasa',
      '2023-10-19 10:00:00',
      '2023-10-19 10:00:00',
      'Lain-Lain',
      '2023-10-20 10:00:00',
      '2023-10-20 10:00:00'
    ]);

// Insert data into tb_sunnah table
    await database.rawInsert(
        'INSERT INTO tb_sunnah (judul, arabic, latin, terjemahan, manfaat, jenis_id, deskripsi, tanggal_pelaksanaan, waktu_pelaksanaan, isHari, created_at, updated_at) '
        'VALUES '
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?),'
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?)',
        [
          // Data 1
          'Puasa Senin-Kamis',
          'لاَ تُلْزِمُ الْجُمْعَةَ بِصَوْمِہَا وَلٰكِنْ كَانَ يَصُوْمُهَا',
          'La tulzimu al-jumata bi-sawmiha walakin kāna yasūmuhā',
          'Janganlah kamu mengaitkan (kewajiban) berpuasa di hari Jumat dengan puasa lainnya, akan tetapi hendaklah kamu berpuasa jika kamu tidak sengaja bersua dengan hari itu.',
          'Puasa Senin-Kamis memiliki banyak manfaat, seperti mendapatkan pahala, membersihkan jiwa, dan mendekatkan diri kepada Allah SWT.',
          2,
          'Puasa pada hari Senin dan Kamis adalah sunnah yang dianjurkan. Nabi Muhammad SAW sering berpuasa pada hari-hari ini. Tidak ada ayat Al-Quran khusus yang mengatur ini, tetapi ada banyak hadis yang meriwayatkan praktik Nabi.',
          '2023-10-02 10:00:00',
          '05:00 - 18:00',
          '1,2',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',

          // Data 1.2
          'Puasa Senin-Kamis',
          'لاَ تُلْزِمُ الْجُمْعَةَ بِصَوْمِہَا وَلٰكِنْ كَانَ يَصُوْمُهَا',
          'La tulzimu al-jumata bi-sawmiha walakin kāna yasūmuhā',
          'Janganlah kamu mengaitkan (kewajiban) berpuasa di hari Jumat dengan puasa lainnya, akan tetapi hendaklah kamu berpuasa jika kamu tidak sengaja bersua dengan hari itu.',
          'Puasa Senin-Kamis memiliki banyak manfaat, seperti mendapatkan pahala, membersihkan jiwa, dan mendekatkan diri kepada Allah SWT.',
          2,
          'Puasa pada hari Senin dan Kamis adalah sunnah yang dianjurkan. Nabi Muhammad SAW sering berpuasa pada hari-hari ini. Tidak ada ayat Al-Quran khusus yang mengatur ini, tetapi ada banyak hadis yang meriwayatkan praktik Nabi.',
          '2023-10-04 10:00:00',
          '05:00 - 18:00',
          '2,3,4',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',

          // Data 2
          'Puasa Pertengahan Bulan',
          'صُوْمُ ثَلاَثَةِ اَیّٰامٍ مِّنْ كُلِّ شَهْرٍ وَّصِیْا مِّا یُّتْرَكُ سِوٰۤآءُ اُوْسَطِ وَاخِرِ سِتٰۤئِیْنَ مِنْ شَهْرِ ذُیْ الْحِجَّةِ',
          'Ṣūmu thalāthati ayyāmin min kulli shaharin waṣiyyā mā yutraku siwāu uṣaṭi wa-akhiri sittīna min shahri dhūl-ḥijjah',
          'Puasa tiga hari setiap bulan dan puasa Ayyam al-Beed (13, 14, 15) adalah puasa yang disyariatkan. Kecuali puasa yang digantikan pada hari itu (yakni puasa tasyrik yang disunatkan)',
          'Puasa pada tanggal 13, 14, dan 15 setiap bulan hijriah (kalender Islam) adalah sunnah yang dianjurkan. Ini juga dianjurkan berdasarkan hadis.',
          2,
          'Puasa pertengahan bulan memiliki manfaat spiritual, seperti mendekatkan diri kepada Allah dan meningkatkan keimanan.',
          '2023-10-18 10:00:00',
          '05:00 - 18:00',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 3
          'Puasa Asyura',
          'صُوْمُ یَّوْمِ عٰشُوْرَآءَ یُکَفِّرُ السَّنَۢیَۚ',
          'Ṣūmu yawmi āshūrā yukaffiru as-sanayā',
          'Puasa hari Asyura menghapus dosa satu tahun yang lalu.',
          'Puasa pada tanggal 9 dan 10 Muharram adalah sunnah yang dianjurkan. Puasa ini juga dikaitkan dengan peristiwa penyelamatan Nabi Musa AS dari Firaun. Terdapat hadis yang meriwayatkan praktik ini.',
          2,
          'Puasa Asyura adalah sarana penghapus dosa, dan mengikuti Sunnah Nabi Musa dalam mengenang peristiwa bersejarah.',
          '2023-07-28 10:00:00',
          '05:00 - 18:00',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 4
          'Puasa Arafah',
          'صُوْمُ یَّوْمِ عَرَفَۃَ اَحْتَسِبُ عَلَی اللّٰہِ اَنْ یُّکَفِّرَ السَّنَۢیَۚ',
          "Ṣūmu yawmi 'Arafah aḥtasibu 'alállāhi an yukaffira as-sanayā",
          'Puasa hari Arafah, aku berharap Allah akan menghapus dosa setahun yang telah lalu dan setahun yang akan datang.',
          'Puasa pada tanggal 9 Dzulhijjah (hari Arafah) bagi yang tidak sedang berhaji adalah sunnah yang sangat dianjurkan. Puasa ini dijelaskan dalam hadis.',
          2,
          'Puasa Arafah memiliki keutamaan besar, di mana Allah mengampuni dosa-dosa hamba-Nya yang telah lalu.',
          '2023-06-28 10:00:00',
          '05:00 - 18:00',
          '1',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 5
          'Puasa Tarwiyah',
          'صُوْمُ یَّوْمِ التَّرْوِیَّۃِ اُحِبُّ اَنْ یُّکُفَّرَ السَّنَۢیَۚ',
          'Ṣūmu yawmi at-tarwīyah uḥibbu an yukaffara as-sanayā',
          'Aku berpuasa pada hari Tarwiyah (8 Dzulhijjah) karena aku ingin menghapus dosa satu tahun yang telah lalu.',
          'Puasa pada tanggal 8 Dzulhijjah, yang dilakukan oleh jamaah haji sebelum mereka berangkat ke Arafah. Ini juga berdasarkan hadis.',
          2,
          'Puasa Tarwiyah membawa keutamaan yang luar biasa, termasuk penghapusan dosa-dosa yang telah lalu.',
          '2023-10-18 10:00:00',
          'Jam 12',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 6
          'Puasa Syawal',
          'مَنْ صَامَ رَمَضٰانَ ثُمَّ اَتْبَعَہٗ سِتًّا مِّنْ شَوٰلٍ کَانَ کَصِیَامِ الدَّۤۢیِۦِ اِلٰۤیۡ',
          "Man ṣāma Ramaḍāna thumma atba'ahu sitta min Shawālin kāna kaṣiyāmi d-dahyī ilá",
          "Barangsiapa yang berpuasa selama bulan Ramadhan kemudian melanjutkannya dengan puasa enam hari dari bulan Syawal, maka dia seperti berpuasa sepanjang tahun.",
          "Puasa Syawal membawa keutamaan besar, di mana pahalanya setara dengan berpuasa sepanjang tahun.",
          2,
          'Puasa pada bulan Syawal, khususnya 6 hari pertama setelah Idul Fitri, adalah sunnah. Nabi Muhammad SAW menganjurkan ini dalam hadis.',
          '2023-04-22 10:00:00',
          '05:00 - 18:00',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 7
          'Puasa Dzulhijjah (1-9)',
          'لَا یُصَوِّمُ یَوْمَ عَرَفَۃَ فِیْ یَوْمِ دُوْنِۢ وَاحِدَۃٍ',
          "Lā yuṣawwimu yawma 'arafata fī yawmi dūnin wāḥidah",
          "Tidak sah berpuasa Arafah (9 Dzulhijjah) jika tidak dipuasa di hari sebelumnya (8 Dzulhijjah).",
          "Puasa pada awal Dzulhijjah memiliki banyak manfaat, termasuk penghapus dosa dan mendapatkan keberkahan.",
          2,
          "Puasa pada 1-9 Dzulhijjah adalah sunnah, dengan puasa Arafah (tanggal 9) sebagai salah satu yang paling dianjurkan. Ini didasarkan pada hadis.",
          '2023-10-18 10:00:00',
          '05:00 - 18:00',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 8
          'Puasa Nisfu Syaban',
          'صُوْمُ خَمْسَ عَشْرَةَ یَوْمًا اِذَا غَشِیَتِ الشَّمٰسُ کُنَّتَ فِیْ مَلَکِہٰۤ',
          "Ṣūmu khamsa 'ashrata yawman idhā ghashiyati ash-shamsu kunnata fī malakiha",
          "Puasa pada lima belas hari di bulan Sya'ban ketika matahari terbenam, akan menjadi tamu (mendapatkan kehormatan) Allah pada malam itu.",
          "Puasa Nisfu Sya'ban membawa berkah dan keutamaan, serta memberikan kesempatan untuk mendapatkan kehormatan Allah.",
          1,
          "Puasa pada tanggal 15 Sya'ban (Nisfu Sya'ban) adalah sunnah yang dianjurkan. Ada beberapa hadis yang meriwayatkan hal ini.",
          '2023-03-07 10:00:00',
          '05:00 - 18:00',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 9
          'Hari Tasyriq',
          'اَیَّامُ التَّشْرِیۡقِ یَوْمُ التَّشْرِیۡقِ وَیَوْمُ التَّشْرِیۡقِ',
          "Ayyāmu t-tashrīq yawmu t-tashrīq wa yawmu t-tashrīq",
          "Hari-hari Tasyriq adalah (hari) Tasyriq, (hari) Tasyriq, dan (hari) Tasyriq.",
          "",
          3,
          "Hari Tasyriq adalah hari-hari (11, 12, dan 13 Dzulhijjah) setelah hari Arafah yang menjadi bagian dari ibadah haji. Tidak ada puasa yang dianjurkan pada hari-hari ini.",
          '2023-10-18 10:00:00',
          'Jam 12',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 10
          'Sholat Tahajud',
          'وَمِنَ اللَّیْلِ فَتَہَجَّدۡ بِہٖ نٰفِلَۃً لَّکَ طٰوِیۡلَۃًؕ عَسٰۤئِہٰ یَبْعَثُکَ رَبُّکَ مَقَامًا مَّحۡمُوۡدًاؕ',
          "Wa mina l-layli fatahajjad bihi nāfilatan laka ṭawīlata 'asā an yab'athuka rabbuka maqāman maḥmūdā",
          "Dan sebahagian malam, berjagalah kamu (untuk shalat) sebagai suatu ibadah tambahan bagimu; mudah-mudahan Tuhan-mu akan membangkitkan kamu kepada tempat yang terpuji.",
          "Sholat Tahajud adalah cara yang sangat baik untuk mendekatkan diri kepada Allah, memohon ampunan, dan memperoleh pahala yang besar.",
          1,
          "Sholat Tahajud adalah sholat malam yang dilakukan pada malam setelah tidur. Ini adalah sholat sunnah yang sangat dianjurkan dan diberkahi. Terdapat banyak hadis yang meriwayatkan keutamaan sholat Tahajud.",
          '2023-10-02 10:00:00',
          '22:00 - 05:00',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 11
          'Sholat Dhuha',
          'قَالَ رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ: فِي جَوْفِ كُلِّكُمْ صَدَقَةٌ، كُلِّ يَوْمٍ تَطْلُعُ عَلَيْهِ الشَّمْسُ تَعْدِلُ بَيْنَ اثْنَتَيْنِ صَدَقَةٍ: تَعِينُ الرَّجُلِ فِي دَابَّتِهِ، فَتُحْمِلُهُ عَلَيْهَا، أَوْ تَرْفَعُ لَهُ إِلَيْهَا مَتَاعَهُ، وَفِي الْمَعْاشِ لَكُلِّكُمْ صَدَقَةٌ، كُلِّ يَوْمٍ تَطْلُعُ عَلَيهِ الشَّمْسُ تَعْدِلُ بَيْنَ اثْنَتَينِ صَدَقَةٍ: تَعِينُ الرَّجلِ فِي نفسِهِ، فَتُقويهِ؛ أَوْ تُقويهَا إِلَيهَا؛ وَالْكَلمةُ الطَّيِّبةُ صَدقَةٌ، وَكُلُّ خُطوةٍ تَمشيهَا إِلَى الصَّلَاةِ صَدقَةٌ، وَتُضعُ عَنها خَطيئةٌ وَتَرفعُ لهُ بِها درجةٌ, قالتِ السَّيِّئَاتُ يا رَسولَ اللَّهِ أَيَأتي أَحَدُنا شهوتهُ ويكون له فيها أجرٌ؟ قالَ: أَرَأيتِ إِذا وَضَعَها فِي حرامٍ أَكانَ عَلَيهِ وِزرٌ, ثم قال: فِي بُضعِ أَحَدِكُم صَدقَةٌ كلِّ يَومٍ تُقي مِنها ابراءَهُ مِنَ النَّارِ,',
          "Qāla Rasūlullāhi ṣallallāhu 'alayhi wa sallam: 'Fī jawfi kullikum ṣadaqatun, kulli yawmin taṭlu'u 'alayhā ash-shamsu ta'dilu bayna ithnatayni ṣadaqah: ta'īnu ar-rajula fī dābbatihi, fatuḥmiluhu 'alayhā, aw tarfa'u lahu ilayhā matā'ahu, wa fīl-ma'āshi lilkullikum ṣadaqatun, kulli yawmin taṭlu'u 'alayhā ash-shamsu ta'dilu bayna ithnatayni ṣadaqah: ta'īnu ar-rajula fī nafsihi, fatuqawwīhā; aw tuqawwīhā ilayhā; wal-kalimatu aṭ-ṭayyibah ṣadaqah, wa kullu khuṭwatin tamshīhā ilāṣ-ṣalāti ṣadaqah, wa tuḍa'u 'an-hā khiṭī'atun wa tarfa'u lahu bihā darajah', qālati as-sayyi'ātu yā rasūlallāhi 'ayata'tī 'aḥadukum shahwatuhu wa yakūnu lahu fīhā ajrun?' qāla: 'ara'aytum iżā waḍa'ahā fī ḥarāmin a-kāna 'alayhi wizrun', thumma qāla: 'fī buḍ'i aḥadikum ṣadaqatun kulli yawmin tuqī min-hā iḥrā'u-hu min-an-nār'",
          'Sholat Isyraq atau Dhuha adalah shalat sunnah yang dianjurkan pada waktu pagi setelah matahari naik. Sholat ini merupakan ungkapan syukur kepada Allah atas terbitnya matahari dan nikmat-Nya.',
          "Sholat Dhuha membawa berkah, menenangkan hati, dan memberikan pahala yang besar.",
          1,
          "Sholat Dhuha adalah sholat sunnah yang dianjurkan pada pagi hari setelah matahari naik. Ini membawa berkah dan pahala. Terdapat hadis yang meriwayatkan keutamaan sholat Dhuha.",
          '2023-10-18 10:00:00',
          '07:00 - 18:00',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 12
          'Sholat Isyraq (Dhuha)',
          'Tidak ada dalil hadist atau ayat Al-Quran yang secara spesifik menyebutkan Sholat Isyraq (Dhuha) secara rinci.',
          'Tidak ada bacaan Arab yang spesifik untuk Sholat Isyraq (Dhuha) karena tidak ada hadist atau ayat Al-Quran yang menjelaskannya secara rinci.',
          'Sholat Isyraq atau Dhuha adalah shalat sunnah yang dianjurkan pada waktu pagi setelah matahari naik. Sholat ini merupakan ungkapan syukur kepada Allah atas terbitnya matahari dan nikmat-Nya.',
          'Sholat Isyraq (Dhuha) adalah ibadah syukur dan membawa berkah serta kebaikan.',
          1,
          'Sholat Isyraq atau Dhuha adalah shalat sunnah yang dianjurkan pada waktu pagi setelah matahari naik. Sholat ini merupakan ungkapan syukur kepada Allah atas terbitnya matahari dan nikmat-Nya.',
          '2023-10-18 10:00:00',
          '07:00 - 18:00',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 13
          'Sholat Rawatib',
          'Tidak ada dalil hadist atau ayat Al-Quran yang secara spesifik menyebutkan Sholat Rawatib secara rinci.',
          "Tidak ada bacaan Arab yang spesifik untuk Sholat Rawatib karena tidak ada hadist atau ayat Al-Qur'an yang menjelaskannya secara rinci.",
          "Sholat Rawatib adalah shalat sunnah yang dianjurkan sebelum atau sesudah shalat wajib tertentu. Sholat ini dikerjakan sebagai bentuk ibadah tambahan dan dapat memberikan berkah.",
          "Melaksanakan Sholat Rawatib dapat mendekatkan diri kepada Allah dan mendapatkan pahala tambahan.",
          1,
          "Sholat Rawatib adalah shalat sunnah yang dianjurkan sebelum atau sesudah shalat wajib tertentu. Sholat ini dikerjakan sebagai bentuk ibadah tambahan dan dapat memberikan berkah.",
          '2023-10-18 10:00:00',
          'Sebelum Sholat',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 14
          'Sholat Witir',
          'Dari Abdullah bin Umar radhiyallahu anhuma, dia berkata, Rasulullah shallallahu alaihi wa sallam berwitr dengan satu rakaat di malam hari. (HR. al-Bukhari no. 998 dan Muslim no. 167)",',
          "Qāla Rasulullahi Shallallahu 'Alaihi Wa Sallama: 'Salatu al-Laili Mathna Mathna, Fa Iza Khifta Ashrata Al-Sab'i Aw Khifta Ashrata Al-Thalathi. Fa Akhiru Bi Witri Witrin.'",
          "Dari Abdullah bin Umar radhiyallahu anhuma, dia berkata, 'Rasulullah shallallahu alaihi wa sallam berwitr dengan satu rakaat di malam hari.' (HR. al-Bukhari dan Muslim)",
          "Sholat Witir adalah shalat sunnah yang memiliki keistimewaan tersendiri. Melaksanakan Sholat Witir dapat mendekatkan diri kepada Allah dan mendapatkan pahala tambahan.",
          1,
          "Sholat Witir adalah shalat sunnah yang dikerjakan pada malam hari. Rasulullah shallallahu alaihi wa sallam menganjurkan untuk mengerjakannya dalam bilangan ganjil, seperti satu rakaat, tiga rakaat, dan sebagainya. Sholat Witir memiliki keistimewaan tersendiri dan dianjurkan untuk melaksanakannya sebagai bentuk ibadah tambahan di malam hari.",
          '2023-10-18 10:00:00',
          '22:00 - 05:00',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 15
          'Sholat Idul Fitri',
          'Tidak ada dalil hadist atau ayat Al-Quran yang secara spesifik menyebutkan Sholat Idul Fitri secara rinci.',
          "Tidak ada bacaan Arab yang spesifik untuk Sholat Idul Fitri karena tidak ada hadist atau ayat Al-Qur'an yang menjelaskannya secara rinci.",
          "Sholat Idul Fitri adalah shalat yang dilaksanakan setelah selesai berpuasa selama bulan Ramadhan. Ini adalah hari raya bagi umat Islam yang mengakhiri bulan suci Ramadhan. Sholat Idul Fitri merupakan ungkapan syukur kepada Allah atas kesempatan untuk berpuasa dan menjalankan ibadah di bulan suci Ramadhan. Selain itu, sholat ini juga menjadi kesempatan untuk memperoleh pengampunan dan keberkahan.",
          "Sholat Idul Fitri merupakan wujud syukur kepada Allah atas berkah bulan Ramadhan dan merupakan kesempatan untuk memperoleh pengampunan dan keberkahan.",
          1,
          "Sholat Idul Fitri adalah shalat yang dilaksanakan setelah selesai berpuasa selama bulan Ramadhan. Ini adalah hari raya bagi umat Islam yang mengakhiri bulan suci Ramadhan. Sholat Idul Fitri merupakan ungkapan syukur kepada Allah atas kesempatan untuk berpuasa dan menjalankan ibadah di bulan Ramadhan. Selain itu, sholat ini juga menjadi kesempatan untuk memperoleh pengampunan dan keberkahan.",
          '2023-04-22 10:00:00',
          '06:00',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 16
          'Sholat Idul Adha',
          'Tidak ada dalil hadist atau ayat Al-Quran yang secara spesifik menyebutkan Sholat Idul Adha secara rinci.',
          "Tidak ada bacaan Arab yang spesifik untuk Sholat Idul Adha karena tidak ada hadist atau ayat Al-Qur'an yang menjelaskannya secara rinci.",
          "Sholat Idul Adha adalah shalat yang dilaksanakan pada hari raya Idul Adha, yang juga dikenal sebagai Hari Raya Qurban. Ini adalah hari besar dalam agama Islam yang dirayakan sebagai wujud syukur atas kesempatan untuk berqurban dan mengikuti ibadah haji. Meskipun tidak ada bacaan Arab spesifik untuk sholat ini, namun sholat ini memiliki makna yang mendalam dalam rangkaian perayaan Idul Adha.",
          "Sholat Idul Adha adalah wujud syukur kepada Allah atas kesempatan untuk berqurban dan mengikuti ibadah haji.",
          1,
          "Sholat Idul Adha adalah shalat yang dilaksanakan pada hari raya Idul Adha, yang juga dikenal sebagai Hari Raya Qurban. Ini adalah hari besar dalam agama Islam yang dirayakan sebagai wujud syukur atas kesempatan untuk berqurban dan mengikuti ibadah haji. Meskipun tidak ada bacaan Arab spesifik untuk sholat ini, namun sholat ini memiliki makna yang mendalam dalam rangkaian perayaan Idul Adha.",
          '2023-06-29 10:00:00',
          '06:00',
          '0',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 17
          'Sholat Wudhu',
          'عَنْ أَبِي هُرَيْرَةَ رَضِيَ اللَّهُ عَنْهُ، قَالَ رَسُولُ اللَّهِ صلى الله عليه وسلم: "إِذَا أَتَيْتُمُ الْمَسْجِدَ فَلَا تَجْلِسُوا حَتَّى تُصَلُّوا رَكْعَتَيْنِ." (رواه البخاري رقم 444 ومسلم رقم 714)',
          'Qala Rasulullahi Shallallahu Alaihi Wa Sallama: "Iza Ataytum Al-Masjida Fala Takudu Hatta Tasbiha Wa Tu Salliya Rakatayni."',
          'Dari Abu Hurairah radhiyallahu anhu, Rasulullah shallallahu alaihi wa sallam bersabda, "Jika salah seorang di antara kalian datang ke masjid, dia tidak boleh duduk sebelum dia shalat dua rakaat." (HR. al-Bukhari dan Muslim)',
          'Melaksanakan Sholat Wudhu membawa keberkahan dan membersihkan diri serta jiwa sebelum melaksanakan shalat wajib.',
          1,
          'Sholat Wudhu adalah shalat sunnah yang dianjurkan setelah melakukan wudhu (berkumur dan membersihkan diri) sebelum shalat wajib. Shalat ini membawa keberkahan dan membersihkan jiwa.',
          '2023-10-18 10:00:00',
          'Fleksibel',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 18
          'Waktu Yang Tidak Boleh Sholat',
          'عَنْ أَبِي هُرَيْرَةَ رَضِيَ اللَّهُ عَنْهُ، قَالَ رَسُولُ اللَّهِ صلى الله عليه وسلم: "إِذَا طَلَعَتِ الشَّمْسُ فَلَا تُصَلُّوا حَتَّى تَطْلُعَ وَإِذَا غَرَبَتِ فَلَا تُصَلُّوا حَتَّى تَغْرُبَ وَلَا تُصَلُّوا حِينَ تَكُونُونَ قَائِمِينَ إِلَّا قَلِيلًا. فَإِذَا رَأَيْتُمْ إِذَا رَأَيْتُمْ هِيَ كَأَنَّهَا كِالْلُّحَمِ قَلَّتْ مِنْهُ السَّيِّأَةُ وَاتَّخَذَتْ سُنَّتَهَا". (رواه البخاري رقم 568 ومسلم رقم 832).',
          'Qala Rasulullahi Shallallahu Alaihi Wa Sallama: "Iza Talati Ash-Shamsu Fala Tusallu Hatta Tatalua Wa Iza Gharabati Fala Tusallu Hatta Taghruba Wa La Tusallu Hina Takunuuna Qaaimiina Illa Qaliila. Faiza Raaytum Iza Raaytum Hiya Kaannaha Ka-Lluhami Qallat Minhu As-Sayyiatu Wa Attakhadhat Sunnataha". (HR. al-Bukhari dan Muslim)',
          'Dari Abu Hurairah radhiyallahu anhu, Rasulullah shallallahu alaihi wa sallam bersabda, "Jika matahari terbit, jangan shalat sampai matahari naik sepenuhnya, dan jika matahari terbenam, jangan shalat sampai matahari benar-benar terbenam. Dan jangan shalat saat berdiri kecuali sedikit. Ketika kalian melihat bahwa matahari telah menjadi seperti dua kulit unta dan sebagian dari penyakitnya telah hilang, maka shalatlah." (HR. al-Bukhari dan Muslim)',
          'Menjauhi shalat pada waktu yang tidak dianjurkan adalah untuk menghormati waktu-waktu tersebut dan menghindari perbuatan yang kurang baik. Waktu-waktu ini mencakup setelah terbitnya matahari (subuh) dan setelah terbenamnya matahari (ashar), meskipun tidak ada penjelasan yang spesifik dalam teks Arab.',
          1,
          'Ada beberapa waktu di mana shalat tidak dianjurkan dilaksanakan, seperti saat terbit dan tenggelamnya matahari, ketika matahari berada tepat di tengah langit (zuhur), dan ketika matahari dalam fase terbenam. Waktu ini dianjurkan untuk menjauhi shalat.',
          '2023-10-18 10:00:00',
          '-',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 19
          'Zikir Pagi Petang',
          'عَنِ ابْنِ مَسْعُوْدٍ رَضِىَ اللّٰهُ عَنْهُ قَالَ رَسُوْلُ اللّٰهِ صَلَّى اللّٰهُ عَلَيْهِ وَسَلَّمَ: "مَنْ قَالَ حِيْنَ يُصْبِحُ وَيُمْسِى: سُبْحَانَ اللّٰهِ وَبِحَمْدِهِ مِاْئَةَ مَرَّةٍ، لَمْ يَاْتِ اَحَدٌ يَّوْمَ الْقِيَامَةِ بِاَفْضَلَ مِمَّا جَآءَ بِهٰۤ اِلَّا رَجُلٌ قَالَ مِثْلَ مَا قَالَ اَوْ زِيَادَةً". (HR. Muslim no. 2692)',
          'Qala Rasulullahi Shallallahu Alaihi Wa Sallama: "Man Qala Hina Yusbihu, Wa Hina Yumsi, Subhanallahi Wa Bihamdihi, Miata Marratin, La Yati Bi Shaiin Yawmi Qiyamati, Ghairu An Yati Bi Mithli Ma Jaat Bihi, Illa Rajulun Qala Mithla Ma Qala Aw Ziyadatan."',
          'Dari Ibn Masud radhiyallahu anhu, Rasulullah shallallahu alaihi wa sallam bersabda, "Barang siapa yang mengucapkan Subhanallahi wa bihamdihi seratus kali pada pagi hari, tidak ada seorang pun yang datang dengan amalan yang lebih baik dari amalannya kecuali orang yang mengucapkan yang serupa atau lebih." (HR. Muslim)',
          'Melaksanakan zikir pagi dan petang membantu kita menjaga kesadaran tentang Allah, memohon rahmat-Nya, dan mendapatkan pahala.',
          3,
          'Zikir pagi dan petang adalah amalan berupa dzikir dan doa yang dianjurkan oleh Rasulullah pada pagi dan petang hari. Dengan berdzikir, kita mengingat Allah dan memohon rahmat-Nya.',
          '2023-10-18 10:00:00',
          '06:00 - 18:00',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 20
          'Surah Al-Waqiah',
          'سورة الواقعة هي السورة رقم 56 في القرآن. تحتوي السورة على دروس وتحذيرات حول الآخرة وتقسيم الناس إلى ثلاث فئات وفضل قراءة هذه السورة.',
          'Surat Al-Waqiah adalah surat ke-56 dalam Al-Quran. Surat ini berisi pelajaran dan peringatan tentang akhirat, pembagian manusia menjadi tiga golongan, dan keutamaan membaca surat ini.',
          'Surah Al-Waqiah is the 56th surah of the Quran. This surah contains lessons and warnings about the Hereafter, the division of people into three groups, and the virtues of reciting this surah.',
          'Membaca Surah Al-Waqiah secara rutin memiliki keutamaan tersendiri, di antaranya membawa berkah, memberikan perlindungan dari kefakiran, dan memberikan cahaya di dalam kubur.',
          3,
          'Surah Al-Waqiah adalah surah ke-56 dalam Al-Quran. Surah ini mengandung pelajaran dan peringatan tentang akhirat, pembagian orang-orang menjadi tiga golongan, dan keutamaan membaca surah ini.',
          '2023-10-18 10:00:00',
          '-',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 21
          'Surah Al-Mulk',
          'سورة الملك هي السورة رقم 67 في القرآن. تحتوي السورة على دروس حول سلطة الله وفضل قراءتها قبل النوم.',
          'Surat Al-Mulk adalah surat ke-67 dalam Al-Quran. Surat ini berisi pelajaran tentang kekuasaan Allah dan keutamaan membaca surat ini sebelum tidur.',
          'Surah Al-Mulk is the 67th surah of the Quran. This surah contains lessons about the power of Allah and the virtue of reciting it before sleep.',
          'Membaca Surah Al-Mulk sebelum tidur memberikan perlindungan dan memberi manfaat di dalam kubur.',
          3,
          'Surah Al-Mulk adalah surah ke-67 dalam Al-Quran. Surah ini mengandung pelajaran tentang kekuasaan Allah dan keutamaan membaca surah ini sebelum tidur.',
          '2023-10-18 10:00:00',
          '-',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
          // Data 22
          'Surah Al-Kahfi',
          'سورة الكهف هي السورة رقم 18 في القرآن. تحتوي السورة على دروس حول الإيمان والابتلاء والحماية من فتنة الدجال.',
          'Surat Al-Kahfi adalah surat ke-18 dalam Al-Quran. Surat ini berisi pelajaran tentang iman, cobaan, dan perlindungan dari fitnah Dajjal.',
          'Surah Al-Kahfi is the 18th surah of the Quran. This surah contains lessons about faith, trials, and protection from the trials of the Dajjal.',
          'Membaca Surah Al-Kahfi pada hari Jumat memberikan cahaya dan perlindungan dari Dajjal.',
          3,
          'Surah Al-Kahfi adalah surah ke-18 dalam Al-Quran. Surah ini mengandung pelajaran tentang iman, cobaan, dan perlindungan dari fitnah Dajjal.',
          '2023-10-18 10:00:00',
          '-',
          '1,2,3,4,5,6,7',
          '2023-10-18 10:00:00',
          '2023-10-18 10:00:00',
        ]);

    DateTime tanggalAwal = DateTime(2023, 1, 1);

    for (int i = 0; i < 365; i++) {
          for (int j = 0; j < 5; j++) {
        int sunnahId = Random().nextInt(22) + 1;
        int isCompleted = Random().nextInt(2);

        DateTime tanggalPelaksanaan = tanggalAwal.add(Duration(days: i));

        String formattedDate =
            '${tanggalPelaksanaan.year}-${tanggalPelaksanaan.month.toString().padLeft(2, '0')}-${tanggalPelaksanaan.day.toString().padLeft(2, '0')}';

        await database.rawInsert('''
    INSERT INTO tb_transaksi_sunnah (user_id, sunnah_id, isCompleted, created_at, updated_at, tanggal_pelaksanaan)
    VALUES (1, ?, ?, '2023-10-18 10:00:00', '2023-10-18 10:00:00', ?)
  ''', [sunnahId, isCompleted, formattedDate]);
      }
    }
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbsobatsunnah.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await SQLHelperJenis.createTablesJenisSunnah(database);
      },
    );
  }

  static Future<int> createJenisSunnah(String namaJenisSunnah) async {
    final db = await SQLHelperJenis.db();

    final data = {'nama_jenis_sunnah': namaJenisSunnah};
    final id = await db.insert('tb_jenis_sunnah', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getJenisSunnah() async {
    final db = await SQLHelperJenis.db();
    return db.query('tb_jenis_sunnah', orderBy: "id_jenis_sunnah");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperJenis.db();
    return db.query('tb_jenis_sunnah',
        where: "id_jenis_sunnah = ? ", whereArgs: [id], limit: 1);
  }

  static Future<int> updateJenisSunnah(int id, String namaJenisSunnah) async {
    final db = await SQLHelperJenis.db();

    final data = {
      'nama_jenis_sunnah': namaJenisSunnah,
      'updated_at': DateTime.now().toString(),
    };

    final result = await db.update('tb_jenis_sunnah', data,
        where: "id_jenis_sunnah = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> deleteJenisSunnah(int id) async {
    final db = await SQLHelperJenis.db();
    return db.delete('tb_jenis_sunnah',
        where: "id_jenis_sunnah = ?", whereArgs: [id]);
  }
}
