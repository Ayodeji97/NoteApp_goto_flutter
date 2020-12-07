import 'package:flutter/material.dart';
import 'package:note_app_goto/screens/note_details.dart';
import 'package:note_app_goto/screens/note_list.dart';


void main () {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notekeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: NoteDetail(),
    );
  }
}
