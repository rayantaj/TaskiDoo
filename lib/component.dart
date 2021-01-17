import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskdo/Task.dart';
import 'package:taskdo/Variables.dart';
import 'DatabaseHelper.dart';
import 'constantsVariables.dart';
import 'main.dart';

class BottomSheetBuilder extends StatefulWidget {
  @override
  _BottomSheetBuilderState createState() => _BottomSheetBuilderState();
}

class _BottomSheetBuilderState extends State<BottomSheetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text('data'),
            TextField(
              onChanged: (text) {
                setState(() {
                  localNewTaskTitle = text;
                });
                //print("First text field: $localNewTaskTitle");
              },
            ),
            TextField(
              onChanged: (text) {
                setState(() {
                  localNewDescription = text;
                });
                //print("Second text field: $localNewDescription");
              },
            ),
            DateTimePicker(
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              onChanged: (val) {
                print(val);
                setState(() {
                  localNewTaskDate = val;
                });
              },
            ),
            Checkbox(
                value: localNewTaskFlag,
                onChanged: (val) {
                  setState(() {
                    localNewTaskFlag = !localNewTaskFlag;
                    // print(localNewTaskFlag);
                  });
                }),
            RaisedButton(
                child: Text('insert'),
                onPressed: () async {
                  Task newCreatedTask = new Task(
                      localNewTaskTitle,
                      localNewDescription,
                      localNewTaskDate,
                      localNewTaskFlag,
                      -1);



                  int id = await DatabaseHelper.instance.insert({
                    DatabaseHelper.colTitle: localNewTaskTitle,
                    DatabaseHelper.colDesc: localNewDescription,
                    DatabaseHelper.colDate: localNewTaskDate,
                    DatabaseHelper.colFlag: localNewTaskFlag ? 1 : 2
                  });



                  print('id is   :    $id');

                  setState(() {

                    databaseTaskList.add(newCreatedTask);
                    localNewTaskDate = null;
                    localNewDescription = " ";
                    localNewTaskFlag = false;
                    localNewTaskTitle = " ";



                    taskList = updateTasks(Globaldate);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context,'/main.dart');


                  });



                  for (int i = 0; i < databaseTaskList.length; i++) {
                    Task temp = databaseTaskList.elementAt(i);
                    temp.id = id;
                    print(temp.getInfo());
                  }


                })
          ],
        ),
      ),
    );
  }
}

String localNewTaskTitle;
String localNewDescription;
String localNewTaskDate;
bool localNewTaskFlag = false;
DateTime tempDate;

//
// DateTimePicker(
// initialValue: '',
// firstDate: now,
// lastDate: DateTime(2100),
// dateLabelText: 'Date',
// onChanged: (val) => print(val),
// // validator: (val) {
// //   setState(() {
// //     localNewTaskDate = val;
// //     tempDate = val as DateTime ;
// //   });
// //   return localNewTaskDate;
// // },
// onSaved: (val) {
// localNewTaskDate = val;
// tempDate = val as DateTime ;
//
// // setState(() {
// //   localNewTaskDate = val;
// //   tempDate = val as DateTime ;
// //
// // });
// print(val);
// // print(val);
// },
// ),
