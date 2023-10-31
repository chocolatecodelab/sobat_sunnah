import 'package:flutter/material.dart';
import 'package:sunnah_reminder/notification/notification_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class ReminderView extends StatefulWidget {
  const ReminderView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  bool isSholatChecked = true;
  bool isPuasaChecked = true;
  bool isSunnahLainnyaChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey,
        elevation: 2,
        actions: [
          // PopupMenuButton(
          //   icon: const Icon(
          //     Icons.notifications_none_outlined,
          //     color: Colors.black,
          //   ),
          //   offset: const Offset(0, 40),
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          //     PopupMenuItem(
          //       child: Row(
          //         children: [
          //           const Text(
          //             'Notifikasi Sunnah Puasa',
          //             style: TextStyle(
          //               color: Colors.black,
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 40,
          //           ),
          //           const Spacer(),
          //           Icon(isPuasaReminderChecked
          //               ? Icons.check_box
          //               : Icons.check_box_outline_blank)
          //         ],
          //       ),
          //       onTap: () {
          //         setState(() {
          //           isPuasaReminderChecked = !isPuasaReminderChecked;
          //         });
          //       },
          //     ),
          //     PopupMenuItem(
          //       child: Row(
          //         children: [
          //           const Text(
          //             'Notifikasi Sunnah Sholat',
          //             style: TextStyle(
          //               color: Colors.black,
          //             ),
          //           ),
          //           const Spacer(),
          //           Icon(isSholatReminderChecked
          //               ? Icons.check_box
          //               : Icons.check_box_outline_blank)
          //         ],
          //       ),
          //       onTap: () {
          //         setState(() {
          //           isSholatReminderChecked = !isSholatReminderChecked;
          //         });
          //       },
          //     ),
          //     PopupMenuItem(
          //       child: Row(
          //         children: [
          //           const Text(
          //             'Notifikasi Sunnah Lainnya',
          //             style: TextStyle(
          //               color: Colors.black,
          //             ),
          //           ),
          //           const Spacer(),
          //           Icon(isSunnahLainnyaReminderChecked
          //               ? Icons.check_box
          //               : Icons.check_box_outline_blank)
          //         ],
          //       ),
          //       onTap: () {
          //         setState(() {
          //           isSunnahLainnyaReminderChecked =
          //               !isSunnahLainnyaReminderChecked;
          //         });
          //       },
          //     ),
          //   ],
          // ),
          PopupMenuButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            offset: const Offset(0, 40),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Row(
                  children: [
                    const Text(
                      'Sunnah Puasa',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Spacer(),
                    Icon(isPuasaChecked
                        ? Icons.check_box
                        : Icons.check_box_outline_blank)
                  ],
                ),
                onTap: () {
                  setState(() {
                    isPuasaChecked = !isPuasaChecked;
                  });
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    const Text(
                      'Sunnah Sholat',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Icon(isSholatChecked
                        ? Icons.check_box
                        : Icons.check_box_outline_blank)
                  ],
                ),
                onTap: () {
                  setState(() {
                    isSholatChecked = !isSholatChecked;
                  });
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    const Text(
                      'Sunnah Lainnya',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Icon(isSunnahLainnyaChecked
                        ? Icons.check_box
                        : Icons.check_box_outline_blank)
                  ],
                ),
                onTap: () {
                  setState(() {
                    isSunnahLainnyaChecked = !isSunnahLainnyaChecked;
                  });
                },
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        title: Text(widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF41966F))),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              viewHeaderHeight: 50,
              headerStyle: const CalendarHeaderStyle(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255,
                      255), // Ubah warna teks header sesuai keinginan Anda
                  fontSize: 18, // Ubah ukuran teks header sesuai keinginan Anda
                ),
                textAlign: TextAlign
                    .center, // Ubah penataan teks sesuai keinginan Anda
                backgroundColor: Color(
                    0xFF74CEA4), // Ubah warna latar belakang header sesuai keinginan Anda
              ),
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: MonthViewSettings(
                  numberOfWeeksInView: 6,
                  agendaItemHeight: 57,
                  showAgenda: true,
                  agendaViewHeight: MediaQuery.of(context).size.height / 3.45,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                  agendaStyle: const AgendaStyle(
                    backgroundColor: Colors.white,
                  )),
              scheduleViewSettings: const ScheduleViewSettings(
                  appointmentItemHeight: 52,
                  hideEmptyScheduleWeek: true,
                  monthHeaderSettings: MonthHeaderSettings(
                    textAlign: TextAlign.center,
                    height: 95,
                  ),
                  dayHeaderSettings: DayHeaderSettings(
                    // Sesuaikan tampilan header harian sesuai kebutuhan Anda
                    dayTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    dayFormat:
                        'EEE', // Format teks yang ditampilkan, misalnya 'EEE' untuk singkatan hari (Sun, Mon, Tue, dll.)
                  ),
                  weekHeaderSettings: WeekHeaderSettings(
                    height: 20,
                    textAlign: TextAlign.start,
                  )),
              appointmentTimeTextFormat: 'HH:mm',
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeInterval:
                    Duration(minutes: 60), // Interval waktu 60 menit (satu jam)
                timeRulerSize:
                    80, // Tinggi ruler waktu sesuai dengan yang Anda inginkan
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Appointment> _getDataSource() {
    final List<Appointment> appointments = <Appointment>[];

    int startYear = 2010;
    int endYear = 2024;
    // Tambahkan jadwal sunnah Sholat Tahajud, Dhuha, dan Rawatib sebagai contoh
    for (int year = startYear; year <= endYear; year++) {
      for (int i = 1; i <= 12; i++) {
        int numberOfDaysInMonth = DateTime(year, i + 1, 0).day;
        for (int day = 1; day <= numberOfDaysInMonth; day++) {
          // Tambahkan jadwal sunnah Sholat Tahajud, Dhuha, dan Rawatib
          HijriCalendar hijriDate =
              HijriCalendar.fromDate(DateTime(year, i, day));

          if (isSholatChecked) {
            // Sholat
            // if (isSholatReminderChecked) {
            //   NotificationController.scheduleSholatNotification("harian");
            // }
            if (hijriDate.hMonth == 9) {
              appointments.add(_createAppointment(
                  'Sholat Tarawih',
                  DateTime(year, i, day, 20, 0, 0),
                  DateTime(year, i, day, 21, 0, 0),
                  const Color(0x0F219C90)));
              appointments.add(_createAppointment(
                'Sholat Witir',
                DateTime(year, i, day, 21, 15, 0),
                DateTime(year, i, day, 21, 45, 0),
                const Color(0xFFF9F3CC),
              ));
            }
            if (hijriDate.hMonth == 10 && hijriDate.hDay == 1) {
              // if (isSholatReminderChecked) {
              //   NotificationController.scheduleSholatNotification("idul fitri");
              // }
              // Sholat Idul Fitri
              appointments.add(_createAppointment(
                'Sholat Idul Fitri',
                DateTime(year, i, day, 7, 0, 0),
                DateTime(year, i, day, 7, 30, 0),
                Colors.red,
              ));
            } else if (hijriDate.hMonth == 12 && hijriDate.hDay == 10) {
              // Sholat Idha
              // if (isSholatReminderChecked) {
              //   NotificationController.scheduleSholatNotification("idul adha");
              // }
              appointments.add(_createAppointment(
                'Sholat Idul Adha',
                DateTime(year, i, day, 7, 0, 0),
                DateTime(year, i, day, 7, 30, 0),
                Colors.purple,
              ));
            }
            appointments.addAll([
              _createAppointment(
                'Sholat Tahajud',
                DateTime(year, i, day, 4, 0, 0),
                DateTime(year, i, day, 5, 0, 0),
                Colors.green,
              ),

              _createAppointment(
                'Sholat Isyraq (Sholat Fajar)',
                DateTime(year, i, day, 5, 0,
                    0), // Ubah waktu sesuai jadwal Sholat Fajar Anda
                DateTime(year, i, day, 6, 0,
                    0), // Ubah waktu sesuai jadwal Sholat Fajar Anda
                const Color(0xFF219C90),
              ),
              // Tambahkan jadwal-jadwal lainnya
              _createAppointment(
                'Sholat Dhuha',
                DateTime(year, i, day, 7, 0, 0),
                DateTime(year, i, day, 8, 0, 0),
                Colors.blue,
              ),
              // Tambahkan jadwal sunnah Sholat Rawatib
              _createAppointment(
                'Sholat Rawatib Zhuhur',
                DateTime(year, i, day, 12, 0, 0),
                DateTime(year, i, day, 12, 15, 0),
                const Color(0xFFFF6969),
              ),
              _createAppointment(
                'Sholat Rawatib Ashar',
                DateTime(year, i, day, 15, 0, 0),
                DateTime(year, i, day, 15, 15, 0),
                Colors.orange,
              ),
              _createAppointment(
                'Sholat Rawatib Maghrib',
                DateTime(year, i, day, 18, 0, 0),
                DateTime(year, i, day, 18, 15, 0),
                const Color(0xFF141E46),
              ),
              _createAppointment(
                'Sholat Rawatib Isya',
                DateTime(year, i, day, 20, 0, 0),
                DateTime(year, i, day, 20, 15, 0),
                const Color(0xFF64CCC5),
              ),
              _createAppointment(
                'Sholat Rawatib Shubuh',
                DateTime(year, i, day, 4, 30, 0),
                DateTime(year, i, day, 4, 45, 0),
                const Color(0xFFF1B4BB),
              ),
            ]);
          }

          if (isPuasaChecked) {
            // Puasa Sunnah
            DateTime monday = DateTime(year, i, day);
            if (monday.weekday == DateTime.monday ||
                monday.weekday == DateTime.thursday) {
              appointments.add(_createAppointment(
                'Puasa Senin-Kamis',
                DateTime(year, i, day, 0, 0, 0),
                DateTime(year, i, day, 23, 59, 59),
                const Color(0xFF687EFF),
              ));
            }

            if (hijriDate.hMonth == 12 &&
                (hijriDate.hDay >= 1 && hijriDate.hDay <= 9)) {
              appointments.add(_createAppointment(
                'Puasa Dzulhijjah',
                DateTime(year, i, day, 0, 0, 0),
                DateTime(year, i, day, 23, 59, 59),
                const Color(0xFFBEADFA),
              ));
            }

            if (hijriDate.hMonth == 8 && hijriDate.hDay == 15) {
              appointments.add(_createAppointment(
                'Puasa Nisfu Sya\'ban',
                DateTime(year, i, day, 0, 0, 0),
                DateTime(year, i, day, 23, 59, 59),
                const Color(0xFFD6D46D),
              ));
            }

            if (hijriDate.hDay >= 13 && hijriDate.hDay <= 15) {
              appointments.add(_createAppointment(
                'Puasa Pertengahan Bulan',
                DateTime(year, i, day, 1, 0, 0),
                DateTime(year, i, day, 2, 0, 0),
                const Color(0xFFB3A492),
              ));
            }

            if (hijriDate.hDay >= 8 &&
                hijriDate.hDay <= 10 &&
                hijriDate.hMonth == 1) {
              appointments.add(_createAppointment(
                'Puasa Hari Asyura',
                DateTime(year, i, day, 0, 0, 0),
                DateTime(year, i, day, 23, 59, 59),
                const Color(0xFFE1AA74),
              ));
            }

            if (hijriDate.hDay == 9 && hijriDate.hMonth == 12) {
              appointments.add(_createAppointment(
                'Puasa Arafah',
                DateTime(year, i, day, 0, 0, 0),
                DateTime(year, i, day, 23, 59, 59),
                const Color(0xFF99B080),
              ));
            }

            if (hijriDate.hDay == 8 && hijriDate.hMonth == 12) {
              appointments.add(_createAppointment(
                'Puasa Tarwiyah',
                DateTime(year, i, day, 0, 0, 0),
                DateTime(year, i, day, 23, 59, 59),
                const Color(0xFF9A4444),
              ));
            }

            if (hijriDate.hDay >= 1 && hijriDate.hMonth == 10) {
              appointments.add(_createAppointment(
                'Puasa Syawal',
                DateTime(year, i, day, 0, 0, 0),
                DateTime(year, i, day, 23, 59, 59),
                Colors.teal,
              ));
            }
          }

          if (isSunnahLainnyaChecked) {
            appointments.addAll([
              _createAppointment(
                'Zikir Pagi Petang',
                DateTime(year, i, day, 5, 0,
                    0), // Ganti waktu sesuai jadwal Zikir Pagi
                DateTime(year, i, day, 6, 0,
                    0), // Ganti waktu sesuai jadwal Zikir Petang
                const Color(0xFF8785A2), // Ganti warna yang sesuai
              ),
              _createAppointment(
                'Surah Al-Waqi\'ah',
                DateTime(year, i, day, 5, 0,
                    0), // Ganti waktu sesuai jadwal Surah Al-Waqi'ah
                DateTime(year, i, day, 6, 0,
                    0), // Ganti waktu sesuai jadwal Surah Al-Waqi'ah
                const Color(0xFFB83B5E), // Ganti warna yang sesuai
              ),
              _createAppointment(
                'Surah Al-Mulk',
                DateTime(year, i, day, 18, 0,
                    0), // Ganti waktu sesuai jadwal Surah Al-Mulk
                DateTime(year, i, day, 18, 15,
                    0), // Ganti waktu sesuai jadwal Surah Al-Mulk
                const Color(0xFF7D5A50), // Ganti warna yang sesuai
              )
            ]);

            if (DateTime(year, i, day).weekday == DateTime.friday) {
              appointments.add(_createAppointment(
                'Surah Al-Kahfi',
                DateTime(year, i, day, 7, 0,
                    0), // Ganti waktu sesuai jadwal Surah Al-Kahfi
                DateTime(year, i, day, 8, 0,
                    0), // Ganti waktu sesuai jadwal Surah Al-Kahfi
                const Color.fromRGBO(
                    255, 199, 199, 1), // Ganti warna yang sesuai
              ));
            }
          }
        }
      }
    }
    return appointments;
  }

  Appointment _createAppointment(
    String subject,
    DateTime startTime,
    DateTime endTime,
    Color color,
  ) {
    return Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: subject,
      color: color,
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
