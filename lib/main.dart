import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'constantsVariables.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'DatabaseHelper.dart';
import 'Variables.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'component.dart';

void main() {
  runApp(MyApp());
  print(DatabaseHelper.instance.initiateDatabase());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es_US', null);
    return MaterialApp(
      title: 'TO-DOO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: myHome(),
    );
  }
}

class myHome extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: Container(child: horizontal_calender()),
    );
  }
}

DateTime now = new DateTime.now();
DateTime Globaldate = new DateTime(now.year, now.month, now.day);

int counter = 0;

Widget txt = Text(counter.toString());

class horizontal_calender extends StatefulWidget {
  @override
  _horizontal_calenderState createState() => _horizontal_calenderState();
}

Widget update() {
  counter++;

  return Text(Globaldate.toString() + counter.toString());
}

bool checkedValue = false;
bool flagImportant = false;

class _horizontal_calenderState extends State<horizontal_calender> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: CalendarTimeline(
            initialDate:
                DateTime(Globaldate.year, Globaldate.month, Globaldate.day),
            firstDate: DateTime(2020, 1, 1),
            lastDate: DateTime(2022, 12, 31),
            onDateSelected: (date) {
              setState(() {
                txt = update();
                Globaldate = DateTime(date.year, date.month, date.day);
              });
            },
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.blueGrey,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.black54,
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',
          ),
        ),

        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  buildSlidable,
                  buildSlidable,
                  buildSlidable,
                  buildSlidable,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, bottom: 15),
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetBuilder();
                      });
                },
                child: Icon(Icons.add),
              ),
            )
          ],
        ),

        // FlatButton(
        //     onPressed: () async {
        //
        //
        //
        //       int i = await DatabaseHelper.instance.insert({
        //         DatabaseHelper.colTitle: 'hospital appointment',
        //         DatabaseHelper.colDesc: 'dr. soliman fakeeh hospital',
        //         DatabaseHelper.colFlag: 1
        //       });
        //
        //       print('id is   :    $i');
        //
        //     },
        //     child: Text('Insert')),
        // FlatButton(onPressed: () async {
        //
        //    var list = (await DatabaseHelper.instance.queryAll()) ;
        //
        //
        //    print(list);
        //
        //
        //
        //
        //
        // }, child: Text('Query')),

        // txt,
      ],
    );
  }

  Slidable get buildSlidable {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: Container(
        height: 140,
        margin: EdgeInsets.only(left: 10, top: 25, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                "Hospital appointment in hirra street ",
                style: (checkedValue == true)
                    ? checkedHeaderTitle
                    : uncheckedHeaderTitle,
              ),
              value: checkedValue,
              onChanged: (newValue) {
                setState(() {
                  checkedValue = newValue;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Dentist appointment with dr.jamal',
                style: description,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // importantFlag,
                  FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          flagImportant = !flagImportant;
                        });
                      },
                      icon: flagImportant ? unimportantFlag : importantFlag,
                      label: Text(''))
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print('delete'),
        ),
      ],
    );
  }
}
