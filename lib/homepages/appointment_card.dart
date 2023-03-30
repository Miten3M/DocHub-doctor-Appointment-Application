import 'package:doc_hub/controllers/appointment_controller.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:doc_hub/models/appointmentcard.dart';
import 'package:doc_hub/models/appointments.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Appointmentcard extends StatefulWidget {
  const Appointmentcard({Key? key}) : super(key: key);

  @override
  State<Appointmentcard> createState() => _AppointmentcardState();
}

class _AppointmentcardState extends State<Appointmentcard> {
  List<AppointmentCardModel> recent = [];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FutureBuilder(
        future: controller.getAllAppointment(),
        builder: (context, snapshot) {
          print("Connetction not done");
          if (snapshot.connectionState == ConnectionState.done) {
            print("Connetction done");
            if (snapshot.hasData) {
              snapshot.data!.sort((a, b) => b.date.compareTo(a.date));

              if (snapshot.data!.isNotEmpty) {
                for (var i in snapshot.data!) {
                  if (i.status == 'upcoming') {
                    recent.add(i);
                  }
                }
                print(recent.length);

                if (recent.length == 1) {
                  AppointmentCardModel mostRecentAppointment = recent.first;
                  return Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    mostRecentAppointment.doc_profile),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    mostRecentAppointment.doctor_name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    mostRecentAppointment.category,
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Config.spaceSmall,
                          ScheduleCard(
                              date: mostRecentAppointment.date,
                              day: mostRecentAppointment.day,
                              time: mostRecentAppointment.time),
                          Config.spaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirmation'),
                                          content: Text(
                                              'Are you sure you want to cancel?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Yes'),
                                              onPressed: () {
                                                AppointmentModel appoint =
                                                    AppointmentModel(
                                                        p_id:
                                                            mostRecentAppointment
                                                                .p_id,
                                                        doc_id:
                                                            mostRecentAppointment
                                                                .doc_id,
                                                        date:
                                                            mostRecentAppointment
                                                                .date,
                                                        time:
                                                            mostRecentAppointment
                                                                .time,
                                                        day:
                                                            mostRecentAppointment
                                                                .day,
                                                        status: "cancelled");

                                                controller.updateAppointment(
                                                    appoint,
                                                    mostRecentAppointment
                                                        .appoint_id,
                                                    mostRecentAppointment.p_id);

                                                // Handle confirm action
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  recent.remove(
                                                      mostRecentAppointment);
                                                });
                                              },
                                            ),
                                            TextButton(
                                              child: Text('No'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Completed',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirmation'),
                                          content: Text(
                                              'Are you sure you visited doctor?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Yes'),
                                              onPressed: () {
                                                AppointmentModel appoint =
                                                AppointmentModel(
                                                    p_id:
                                                    mostRecentAppointment
                                                        .p_id,
                                                    doc_id:
                                                    mostRecentAppointment
                                                        .doc_id,
                                                    date:
                                                    mostRecentAppointment
                                                        .date,
                                                    time:
                                                    mostRecentAppointment
                                                        .time,
                                                    day:
                                                    mostRecentAppointment
                                                        .day,
                                                    status: "completed");

                                                controller.updateAppointment(
                                                    appoint,
                                                    mostRecentAppointment
                                                        .appoint_id,
                                                    mostRecentAppointment.p_id);

                                                // Handle confirm action
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  recent.remove(
                                                      mostRecentAppointment);
                                                });
                                              },
                                            ),
                                            TextButton(
                                              child: Text('No'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Material(

                      color: Colors.transparent,
                    child:Text("No Recent Appointments!!",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,height: 10),),
                  );
                }
              } else {
                return Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[

                          Text("No Recent Appointments!!",style: TextStyle(color: Colors.white,height: 10),),

                        ],),
                    ));
              }
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Material(
                  color: Colors.transparent,
                  child: Text("Something went wrong"));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
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
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "$day, $date",
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            "$time",
            style: TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }
}
