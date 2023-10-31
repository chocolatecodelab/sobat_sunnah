import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import pustaka intl
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';
import 'package:sunnah_reminder/challenge/model/tb_jenis_sunnah_helper.dart';

import 'model/tb_transaksi_sunnah_helper.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  // Buat dua list kosong untuk kedua kriteria
  List<Map<String, dynamic>> completedTasks = [];
  List<Map<String, dynamic>> uncompletedTasks = [];

  void _refreshTransaksi(DateTime hari) async {
    final dataUncompleted =
        await SQLHelperTransaksi.getItemsByDayIsNotCompleted(hari);
    final dataCompleted = await SQLHelperTransaksi.getItemsDayIsCompleted(hari);
    setState(() {
      completedTasks = dataCompleted;
      uncompletedTasks = dataUncompleted;
    });
  }

  static var currentdate = DateTime.now();

  Future<void> _updateItem(int? id) async {
    await SQLHelperTransaksi.updateTransaksi(id!);
    _refreshTransaksi(DateTime(2023, 10, 27));
  }

  int daysInMonth = DateTime(currentdate.year, currentdate.month + 1, 0).day;

  // Mengonversi tanggal Gregorian ke tanggal Hijriah Indonesia
  String getHijriDate(DateTime gregorianDate) {
    final hijriDate = Hijriyah.fromDate(gregorianDate);
    return '${hijriDate.hDay} ${hijriDate.getLongMonthName()} ${hijriDate.hYear}';
  }

  @override
  void initState() {
    super.initState();
    _refreshTransaksi(DateTime(2023, 10, 27));
  }

  @override
  Widget build(BuildContext context) {
    // Future<double> refreshAndCalculateCompletionPercentage() async {
    //   await _refreshTransaksi(DateTime(2023, 10, 27));
    //   double completionPercentage = calculateCompletionPercentage();
    //   return completionPercentage;
    // }
    //
    // for (int idx = 0; idx < _dataTransaksi.length; idx++) {
    //   if (_dataTransaksi[idx]['isCompleted'] == 1) {
    //     completedTasks.add(_dataTransaksi[idx]);
    //   } else {
    //     uncompletedTasks.add(_dataTransaksi[idx]);
    //   }
    // }

    int totalTasks = uncompletedTasks.length + completedTasks.length;
    int completedTasksCount = completedTasks.length;

    double completionPercentage =
        totalTasks > 0 ? (completedTasksCount / totalTasks) * 100 : 0;
    int completionPercentageInt =
        completionPercentage.isFinite ? completionPercentage.toInt() : 0;

    DateTime initialDate = DateTime(currentdate.year, currentdate.month, 1);
    ScreenUtil.init(context); // Inisialisasi konfigurasi layar
    const customTextStyle = TextStyle(
      fontSize: 15,
      color: Color(0xFF41966F),
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey,
        elevation: 2,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFF41966F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 14.0), // Ganti dengan nilai padding yang diinginkan
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_left,
                    color: Color(0xFF41966F), // Ganti warna ikon menjadi hijau
                  ),
                  onPressed: () {
                    // Mengganti bulan ke belakang (misalnya: -1 bulan)
                    setState(() {
                      currentdate =
                          DateTime(currentdate.year, currentdate.month - 1);
                      daysInMonth =
                          DateTime(currentdate.year, currentdate.month + 1, 0)
                              .day;
                    });
                  },
                ),
                Text(
                  DateFormat('MMMM y').format(
                      currentdate), // Menggunakan DateTime.now() sebagai tanggal
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 17.sp),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_right,
                    color: Color(0xFF41966F), // Ganti warna ikon menjadi hijau
                  ),
                  onPressed: () {
                    // Mengganti bulan ke depan (misalnya: +1 bulan)
                    setState(() {
                      currentdate =
                          DateTime(currentdate.year, currentdate.month + 1);
                      daysInMonth =
                          DateTime(currentdate.year, currentdate.month + 1, 0)
                              .day;
                    });
                  },
                ),
              ],
            ),
            Text(
              getHijriDate(currentdate),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 11.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            _buildDatePicker(context, initialDate, daysInMonth),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft, // Menggeser elemen ke kiri
              child: Text(
                'Tantangan Sunnah',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pencapaian : $completionPercentageInt%', // Menampilkan persentase tanpa desimal
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                value:
                    (totalTasks > 0) ? (completedTasksCount / totalTasks) : 0,
                backgroundColor: Colors.grey,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return <Widget>[
                  const SliverToBoxAdapter(
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // Menggeser elemen ke kiri
                      child: Text(
                        'Belum Selesai',
                        style: customTextStyle,
                      ),
                    ),
                  )
                ];
              },
              body: ListView(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: uncompletedTasks.isEmpty
                        ? 1
                        : uncompletedTasks
                            .length, // Tambahkan cek apakah tasks kosong
                    itemBuilder: (context, index) {
                      if (uncompletedTasks.isEmpty) {
                        return _nodatawidget();
                      } else {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            leading: const Icon(
                              Icons.alarm,
                              color: Color(0xFF41966F),
                            ),
                            title: Text(uncompletedTasks[index]['judul']),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 15.0,
                                ),
                                const SizedBox(width: 8.0),
                                Text(uncompletedTasks[index]
                                    ['waktu_pelaksanaan']),
                              ],
                            ),
                            // trailing: Checkbox(
                            //   value: tasks[index].isCompleted,
                            //   shape: const CircleBorder(),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       tasks[index].isCompleted = value!;
                            //       if (value) {
                            //         selectedItems.add(tasks[index]);
                            //         selectedTime.add(time[index]);
                            //         tasks.remove(tasks[index]);
                            //         time.remove(time[index]);
                            //         completedTasks++;
                            //       }
                            //     });
                            //   },
                            // ),

                            trailing: Checkbox(
                              value: false,
                              shape: const CircleBorder(),
                              onChanged: (value) {
                                if (value == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Konfirmasi'),
                                        content: const Text(
                                            'Apakah Anda yakin ingin menyelesaikan tugas ini?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Batal'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Ya'),
                                            onPressed: () {
                                              _updateItem(
                                                  uncompletedTasks[index]
                                                      ['id_transaksi_sunnah']!);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  // Tindakan ketika checkbox tidak dicentang
                                  setState(() {
                                    uncompletedTasks[index]['isCompleted'] = 0;
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const Text('Selesai', style: customTextStyle),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: completedTasks.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          leading: const Icon(
                            Icons.alarm,
                            color: Color(0xFF41966F),
                          ),
                          title: Text(completedTasks[index]['judul']),
                          subtitle: Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 15.0,
                              ),
                              const SizedBox(width: 8.0),
                              Text(completedTasks[index]['waktu_pelaksanaan']),
                            ],
                          ),
                          trailing: const Checkbox(
                            value: true,
                            shape: CircleBorder(),
                            onChanged: null,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _nodatawidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          const Icon(
            Icons.playlist_add_check_circle,
            size: 50, // Atur ukuran ikon menjadi 48 (ukuran dalam piksel)
            color: Color(0xFF41966F), // Ganti warna ikon menjadi hijau
          ),
          SizedBox(height: 5.h),
          Text(
            'Selamat! Tantangan hari ini telah selesai',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 10.h)
        ],
      ),
    );
  }

  Widget _buildDatePicker(
      BuildContext context, DateTime initialDate, int daysInMonth) {
    return DatePicker(
      initialDate,
      daysCount: daysInMonth,
      width: 63.w,
      height: 90.h,
      initialSelectedDate: currentdate,
      dateTextStyle:
          Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18.sp),
      dayTextStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontSize: 10.sp, color: Colors.black),
      monthTextStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontSize: 10.sp, color: Colors.black),
      selectionColor: const Color(0xFF41966F),
      selectedTextColor: const Color(0xFFF2F2F2),
      onDateChange: (DateTime newdate) {
        setState(() {
          currentdate = newdate;
          _refreshTransaksi(currentdate);
        });
      },
    );
  }
}

class Task {
  String title;
  bool isCompleted;

  Task(this.title, {this.isCompleted = false});
}
