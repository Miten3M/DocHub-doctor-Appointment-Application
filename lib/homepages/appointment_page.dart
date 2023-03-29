import 'package:doc_hub/controllers/appointment_controller.dart';
import 'package:doc_hub/controllers/doctor_list_controller.dart';
import 'package:doc_hub/homepages/booking_page.dart';
import 'package:doc_hub/models/appointmentcard.dart';
import 'package:doc_hub/models/appointments.dart';
import 'package:doc_hub/models/doctor.dart';
import 'package:get/get.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}



class _AppointmentPageState extends State<AppointmentPage> {

  Alignment _alignment = Alignment.centerLeft;
  int currentIndex = 0;
  int _lightIsOn = 0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());
    List<AppointmentCardModel> completed = [], upcoming = [], cancelled = [];
    //Future<List<DoctorModel>> schedules= controller.getAllAppointment();
    // List<dynamic> filteredSchedules = schedules.where((AppointmentCardModel schedule){
    //   switch(schedule.status){
    //     case 'upcoming':
    //       schedule.status=FilterStatus.upcoming;
    //       break;
    //     case 'complete':
    //       schedule.status=FilterStatus.complete;
    //       break;
    //     case 'cancel':
    //       schedule.status=FilterStatus.cancel;
    //       break;
    //   }
    //   return schedule.status == status;
    // }).toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: FutureBuilder(
          future: controller.getAllAppointment(),
          builder: (context, snapshot) {
            print("Connetction not done");
            if (snapshot.connectionState == ConnectionState.done) {
              print("Connetction done");
              if (snapshot.hasData) {
                for (var i in snapshot.data!) {
                  if (i.status == 'completed') {
                    completed.add(i);
                  } else if (i.status == 'upcoming') {
                    upcoming.add(i);
                  } else {
                    cancelled.add(i);
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Appointment Schedule',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 0;
                                    _lightIsOn =0;
                                  });
                                },
                                child: AnimatedAlign(
                                  alignment: Alignment.centerLeft,
                                  duration: const Duration(milliseconds: 200),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:_lightIsOn==0?Colors.teal:Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Upcoming",
                                        style:  TextStyle(
                                          color: _lightIsOn==0?Colors.white:Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 1;
                                    _lightIsOn = 1;
                                  });
                                },
                                child: AnimatedAlign(
                                  alignment: Alignment.center,
                                  duration: const Duration(milliseconds: 200),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _lightIsOn==1?Colors.teal:Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Completed",
                                        style:  TextStyle(
                                          color: _lightIsOn==1?Colors.white:Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 2;
                                    _lightIsOn = 2;

                                  });
                                },
                                child: AnimatedAlign(
                                  alignment: Alignment.centerRight,
                                  duration: const Duration(milliseconds: 200),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _lightIsOn==2?Colors.teal:Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: _lightIsOn==2?Colors.white:Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Config.spaceSmall,
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentIndex==0?upcoming.length:currentIndex==1?completed.length:cancelled.length,
                        itemBuilder: ((context, index) {
                          // AppointmentCardModel schedule=snapshot.data![index];
                          bool isLastElement =
                              snapshot.data!.length + 1 == index;
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            currentIndex==0 ? upcoming[index].doc_profile : currentIndex==1 ? completed[index].doc_profile : cancelled[index].doc_profile),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentIndex==0 ? upcoming[index].doctor_name : currentIndex==1 ? completed[index].doctor_name: cancelled[index].doctor_name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            currentIndex==0 ? upcoming[index].category : currentIndex==1 ? completed[index].category : cancelled[index].category,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ScheduleCard(
                                      date: currentIndex==0 ? upcoming[index].date : currentIndex==1 ? completed[index].date : cancelled[index].date,
                                      day: currentIndex==0 ? upcoming[index].day : currentIndex==1 ? completed[index].day : cancelled[index].day,
                                      time: currentIndex==0 ? upcoming[index].time : currentIndex==1 ? completed[index].time : cancelled[index].time),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {AppointmentModel appoint=AppointmentModel(
                                              p_id: currentIndex==0 ? upcoming[index].p_id : currentIndex==1 ? completed[index].p_id : cancelled[index].p_id,
                                              doc_id:currentIndex==0 ? upcoming[index].doc_id : currentIndex==1 ? completed[index].doc_id : cancelled[index].doc_id ,
                                              date: currentIndex==0 ? upcoming[index].date : currentIndex==1 ? completed[index].date : cancelled[index].date,
                                              day: currentIndex==0 ? upcoming[index].day : currentIndex==1 ? completed[index].day : cancelled[index].day,
                                              time: currentIndex==0 ? upcoming[index].time : currentIndex==1 ? completed[index].time : cancelled[index].time,
                                              status:"cancelled");
                                              controller.cancelAppointment(appoint,currentIndex==0 ? upcoming[index].appoint_id: currentIndex==1 ? completed[index].appoint_id : cancelled[index].appoint_id , currentIndex==0 ? upcoming[index].p_id : currentIndex==1 ? completed[index].p_id : cancelled[index].p_id);
                                              setState(() {

                                              });},
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Config.primaryColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                            Config.primaryColor,
                                          ),
                                          onPressed: () {
                                            Get.to(BookingPage(),arguments: {"p_id":currentIndex==0 ? upcoming[index].p_id : currentIndex==1 ? completed[index].p_id : cancelled[index].p_id,"doc_id":currentIndex==0 ? upcoming[index].doc_id : currentIndex==1 ? completed[index].doc_id : cancelled[index].doc_id});},
                                          child: const Text(
                                            'Reschedule',
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {Key? key, required this.date, required this.day, required this.time})
      : super(key: key);
  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: Config.primaryColor.shade300,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "$day  $date",
            style: TextStyle(color: Config.primaryColor.shade300),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Config.primaryColor.shade300,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            time,
            style: TextStyle(color: Config.primaryColor.shade300),
          ))
        ],
      ),
    );
  }
}
