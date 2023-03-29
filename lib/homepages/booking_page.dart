import 'package:doc_hub/Repository/appointment_repo.dart';
import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/components/custom_appbar.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:doc_hub/homepages/success_booked.dart';
import 'package:doc_hub/main.dart';
import 'package:doc_hub/models/appointments.dart';
import 'package:doc_hub/models/dateConverter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';


DateTime setDate = DateTime.now();
class BookingPage extends StatefulWidget {
  BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token;//get token for insert booking date and time into database
  final appointRepo = Get.put(AppointmentRepository());
  
  Future<void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    // final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    print(Get.arguments['p_id']);
    print(Get.arguments['doc_id']);
    final _authRepo=Get.put(AuthenticationRepository());
    var email=_authRepo.firebaseUser.value?.email;
    print(email);
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 30),
              alignment: Alignment.center,
              child: const Text(
                'Weekend is not available, please select another date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          )
              : SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _timeSelected = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: _currentIndex == index
                          ? Config.primaryColor
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                        _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.5),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                ),
                //width: double.infinity,
                child: const Text( 'Make Appointment'),
                //onPressed: () =>
                 onPressed:  () async
                 {
                   //convert date/day/time into string first
                   final getDate = DateConverted.getDate(_currentDay);
                   final getDay = DateConverted.getDay(_currentDay.weekday);
                   final getTime = DateConverted.getTime(_currentIndex!);
                   final appointment = AppointmentModel(
                       doc_id: '${Get.arguments['doc_id']}',
                       date: getDate,
                       time: getTime,
                       day: getDay,
                        p_id:'${Get.arguments['p_id']}');
                   appointRepo.addAppointment(
                       appointment, Get.arguments['p_id'],email
                       );
                   // Get.to(AppointmentBooked());
                   // final booking = await DioProvider().bookAppointment(
                   //     getDate, getDay, getTime, doctor['doctor_id'], token!);
                   //
                   // //if booking return status code 200, then redirect to success booking page

                   // if (booking == 200) {
                   //     () => Get.to(AppointmentBooked());
                   //MyApp.navigatorKey.currentState!.pushNamed('success_booking');
                   //   }
                   },
                   // disable : _timeSelected && _dateSelected ? false : true,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
        BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}

