import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:taskdo/Task.dart';
import 'constantsVariables.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'DatabaseHelper.dart';
import 'Variables.dart';
import 'constantsVariables.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MaterialApp(
        title: 'TO-DOO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: myHome(),
      );
    });
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

bool flagImportant = false;

class _horizontal_calenderState extends State<horizontal_calender> {
  @override
  @override
  void initState() {
    // TODO: implement initState

    loadTasksList();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: CalendarTimeline(
            initialDate:
                DateTime(Globaldate.year, Globaldate.month, Globaldate.day),
            firstDate: DateTime(2020, 1, 1),
            lastDate: DateTime(2022, 12, 31),
            onDateSelected: (date) {
              // databaseTaskList.clear();
              Globaldate = date;
              setState(() {
                // sleep(Duration(seconds: 5));
                print('object');
                // loadTasksList();
                // print("clicked on a day card");

                // // txt = update();
                // //print('changed to ${date.toString()} ');
                // Globaldate = DateTime(date.year, date.month, date.day);
                //

                for (int i = 0; i < taskList.length; i++) {
                  if (taskList[i].completed == true) {
                    DatabaseHelper.instance.delete(taskList[i].id);
                  }
                }

                loadTasksList();
                taskList = updateTasks(Globaldate);
                print("tasklist ${taskList.length} ");
                for (int i = 0; i < taskList.length; i++) {}
                // print("finished on a day card");
                // // print(tasksList.length);
              });
            },
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.blueGrey,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.black54,
            // selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',
          ),
        ),
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            TasksCard(),
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
            ),
          ],
        ),
      ],
    );
  }
}

class TasksCard extends StatefulWidget {
  @override
  _TasksCardState createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      child: Taskcards(),
    );
  }
}

void loadTasksList() async {
  print("Load method ");
  List<Map<String, dynamic>> list = await (DatabaseHelper.instance.queryAll());
// tasksList = list.cast<Task>() ;
//   print(list.first.values.elementAt(1));
  databaseTaskList.clear();
  for (int i = 0; i < list.length; i++) {
    Task newTempTask = new Task(null, null, null, false, 0);

    newTempTask.id = list[i].values.elementAt(0);
    newTempTask.title = list[i].values.elementAt(1);
    newTempTask.description = list[i].values.elementAt(2);
    newTempTask.date = list[i].values.elementAt(3);
    newTempTask.flag = list[i].values.elementAt(4) == 1 ? false : true;
    // print( newTempTask.date)     ;

    databaseTaskList.add(newTempTask);

    // print(list[i].values.elementAt(0));
    // print(list[i].values.elementAt(1));
    // print(list[i].values.elementAt(2));
    // print(list[i].values.elementAt(3));
    // print(list[i].values.elementAt(4).toString() + " \n");
  }

  taskList = updateTasks(Globaldate);

  // print(tasksList.length);
}

List<Task> updateTasks(date) {
  //  print(tasksList[4].date);
  List dates = date.toString().split(" ");
  //print(dates[0]);
  //print(tasksList[4].date == dates[0]);

  List<Task> tempTaskList = List<Task>();

  for (int i = 0; i < databaseTaskList.length; i++) {
    if (databaseTaskList[i].date == dates[0]) {
      tempTaskList.add(databaseTaskList[i]);
      // print(tempTaskList[i].date)  ;
    }

    // print(tasksList[i].date );
  }
  // print(tempTaskList[0].date);
  return tempTaskList;
}

class Taskcards extends StatefulWidget {
  @override
  _TaskcardsState createState() => _TaskcardsState();
}

class _TaskcardsState extends State<Taskcards> {
  @override
  Widget build(BuildContext context) {
    return taskList.length == 0
        ? Text("data")
        : ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return Container(
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
                        taskList[index].title,
                        style: taskList[index].completed
                            ? checkedHeaderTitle
                            : uncheckedHeaderTitle,
                      ),
                      value: taskList[index].completed,
                      onChanged: (newValue) {
                        setState(() {
                          taskList[index].completed =
                              !taskList[index].completed;
                        });
                        // DatabaseHelper.instance.delete(taskList[index].id);
                        // loadTasksList();
                        // setState(() {
                        //
                        //   DatabaseHelper.instance.delete(taskList[index].id);
                        //   loadTasksList();
                        //
                        //   taskList = updateTasks(Globaldate);
                        //   // Here you can write your code for open new view
                        // });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        taskList[index].description,
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
                                  int flag = taskList[index].flag ? 1 : 2;

                                  DatabaseHelper.instance
                                      .update(taskList[index].id, flag);
                                  loadTasksList();
                                  taskList = updateTasks(Globaldate);

                                  taskList[index].flag = !taskList[index].flag;
                                });
                              },
                              icon: taskList[index].flag
                                  ? unimportantFlag
                                  : importantFlag,
                              label: Text(''))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}

class AppBuilder extends StatefulWidget {
  final Function(BuildContext) builder;

  const AppBuilder({Key key, this.builder}) : super(key: key);

  @override
  AppBuilderState createState() => new AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<AppBuilderState>());
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}
