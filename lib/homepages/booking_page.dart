
import 'package:doc_hub/homepages/config.dart';
import 'package:doc_hub/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
DateTime setDate = DateTime.now();
class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  CalendarDatePicker _format=CalendarDatePicker(initialDate: setDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 100000)), onDateChanged: (DateTime value) {},);
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Application',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _format,
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

