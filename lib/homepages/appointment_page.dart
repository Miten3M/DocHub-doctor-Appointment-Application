import 'package:doc_hub/controllers/appointment_controller.dart';
import 'package:doc_hub/controllers/doctor_list_controller.dart';
import 'package:doc_hub/models/appointmentcard.dart';
import 'package:doc_hub/models/doctor.dart';
import 'package:get/get.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:flutter/material.dart';
class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus {upcoming,complete,cancel}

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status=FilterStatus.upcoming;
  Alignment _alignment=Alignment.centerLeft;
  
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());
    // Future<List<DoctorModel>> schedules= controller.getAllAppointment(id);
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
          padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
          child: FutureBuilder(
            future: controller.getAllAppointment(),
            builder: (context, snapshot) {
              print("Connetction not done");
              if (snapshot.connectionState == ConnectionState.done) {
                print("Connetction done");
                if (snapshot.hasData) {

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
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
                                for(FilterStatus filterStatus in FilterStatus.values)
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          if(filterStatus==FilterStatus.upcoming){
                                            status=FilterStatus.upcoming;
                                            _alignment=Alignment.centerLeft;
                                          }else if(filterStatus==FilterStatus.complete){
                                            status=FilterStatus.complete;
                                            _alignment=Alignment.center;
                                          }else if(filterStatus==FilterStatus.cancel){
                                            status=FilterStatus.cancel;
                                            _alignment=Alignment.centerRight;
                                          }
                                        });
                                      },
                                      child: Center(
                                        child: Text(filterStatus.name),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          AnimatedAlign(
                            alignment: _alignment,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Config.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  status.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Config.spaceSmall,
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context,index){
                            // AppointmentCardModel schedule=snapshot.data![index];
                            bool isLastElement=snapshot.data!.length+1==index;
                            return Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: !isLastElement
                                  ?const EdgeInsets.only(bottom: 20)
                                  :EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(snapshot.data![index].doc_profile),
                                        ),
                                        const SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].doctor_name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                              snapshot.data![index].category,
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
                                    ScheduleCard(date: snapshot.data![index].date, day: snapshot.data![index].day, time: snapshot.data![index].time),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: (){},
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(color: Config.primaryColor),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: Config.primaryColor,
                                            ),
                                            onPressed: (){},
                                            child: const Text(
                                              'Reschedule',
                                              style: TextStyle(color: Colors.white),
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
  const ScheduleCard({Key? key, required this.date, required this.day, required this.time}) : super(key: key);
  final String date;
  final String day;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Colors.grey.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  <Widget>[
          Icon(
            Icons.calendar_today,
            color:Config.primaryColor,
            size: 15,
          ),
          SizedBox(width: 5,),
          Text(
            "$day$date",
            style: TextStyle(color: Config.primaryColor),
          ),
          SizedBox(width: 20,),
          Icon(
            Icons.access_alarm,
            color:Config.primaryColor,
            size: 17,
          ),
          SizedBox(width: 5,),
          Flexible(child: Text('2:00 PM',style: TextStyle(color: Config.primaryColor),))
        ],
      ),
    );
  }
}
