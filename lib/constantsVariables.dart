import 'package:flutter/material.dart';

TextStyle uncheckedHeaderTitle =
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600);

TextStyle checkedHeaderTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.lineThrough);

TextStyle description = TextStyle(color: Colors.black45);

Icon importantFlag= Icon(Icons.flag, color: Colors.orange,size: 25) ;
Icon unimportantFlag= Icon(Icons.flag, color: Colors.grey.shade300,size: 25) ;