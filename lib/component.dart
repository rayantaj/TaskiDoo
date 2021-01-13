


import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                print("First text field: $localNewTaskTitle");
              },
            ),
            TextField(
              onChanged: (text) {
                setState(() {
                  localNewDescription = text;
                });
                print("Second text field: $localNewDescription");
              },
            ),
            DateTimePicker(
              initialValue: '',
              firstDate: now,
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              onChanged: (val) => print(val),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) {
                localNewTaskDate = val as DateTime;
                print(localNewTaskDate.toString());
              },
            ),
            Checkbox(
                value: localNewTaskFlag,
                onChanged: (val) {
                  setState(() {
                    localNewTaskFlag = !localNewTaskFlag;
                    print(localNewTaskFlag);
                  });
                })
          ],
        ),
      ),
    );
  }
}

String localNewTaskTitle;
String localNewDescription;
DateTime localNewTaskDate;
bool localNewTaskFlag = false;


