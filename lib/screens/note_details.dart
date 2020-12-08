import 'package:flutter/material.dart';
import 'dart:async';
import 'package:note_app_goto/models/note.dart';
import 'package:note_app_goto/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {



  // Note : WillPopScope will allow you to control the back button of your user device
  // used in changing the appBar dynamically;
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  _NoteDetailState createState() => _NoteDetailState(this.note, this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {



  String appBarTitle;
  Note note;

  static var _priorities = ['High', 'Medium', 'Low'];
  // used to control what the user enter into the text field

  // database instance
  DatabaseHelper helper = DatabaseHelper();



  _NoteDetailState(this.note, this.appBarTitle);



  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    // assign note passed from list screen to the form
    titleController.text = note.title;
    descriptionController.text = note.description;


    TextStyle textStyle = Theme.of(context).textTheme.title;
    return WillPopScope (
      // define what will happen when the user click on the back button
      onWillPop: () {
        // control the back navigation on your user device
        moveToLastScreen();
      },
        child : Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(icon: Icon(
          Icons.arrow_back),
          onPressed: () {
            // control the back navigation on your user device
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
        child: ListView(
          children: <Widget>[

            ListTile(
              title: DropdownButton(
                items : _priorities.map((String value) => DropdownMenuItem <String>(
                    value: value,
                    child: Text(value),
                )).toList(),
                style: textStyle,
                value: getPriorityAsString(note.priority),
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('User Selected $valueSelectedByUser');
                    // convert what the user to int value which is compatible with our database
                    updatePriorityAsInt(valueSelectedByUser);
                  });
                },
              ),
            ),

            // second element which is a form field
            Padding (
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('title...');
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  hintText: 'Enter note title...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
            ),

            Padding (
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Description...');
                  updateDescription();
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    hintText: 'Enter note title...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),

                      onPressed: () {
                        // do something here
                        setState(() {
                          debugPrint('Great');
                          _save();
                        });
                      },
                    ),
                  ),

                  Container(width: _minimumPadding * 5),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),

                      onPressed: () {
                        // do something here
                        debugPrint('Cancel');
                        _delete();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    ));
  }

  void moveToLastScreen () {
    Navigator.pop(context, true);
  }

  // convert the string priority to integer before saving in to the database
  void updatePriorityAsInt (String priority) {
    switch(priority) {
      case 'High' :
        note.priority = 1;
        break;
      case 'Medium' :
        note.priority = 2;
        break;
      case 'Low' :
        note.priority = 3;
        break;
    }
  }

  // convert the int priority to the string priority and display to the user in dropdown
  String getPriorityAsString (int value) {
    String priority;
    switch(value) {
      case 1 :
        priority = _priorities[0];
        break;
      case 2 :
        priority = _priorities[1];
        break;
      case 3 :
        priority = _priorities[2];
        break;
    }

    return priority;

  }

  // Helper function to update the title and the description object to the user inputted
  void updateTitle () {
    note.title = titleController.text;
  }

  void updateDescription () {
    note.description = descriptionController.text;
  }

  // function to save data to database
  void _save () async {

    // navigate back to last screen
    moveToLastScreen();

    // update the date the user insert or update the note
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id == null) {  // update the database
      result = await helper.updateNote(note);
    } else { // insert to database
      result = await helper.insertNote(note);
    }

    // check if result is a success or a failure
    if (result != 0) {  // success
      _showAlertDialog ('Status', 'Note Saved Successfully');
    } else { // failure
      _showAlertDialog ('Status', 'Problem Saving Note');
    }
  }

  void _delete () async {

    moveToLastScreen();
    // case 1 : if the user want to delete a newly added note through pressing the FAB
    if (note.id == null) {
      _showAlertDialog('Status', 'No note was deleted');
    }
    // case 2 : user is trying to delete the old note that already has a valid id

    int result = await helper.deleteNote(note.id);

    // check if the note was deleted successfully
    if (result != 0) {
      _showAlertDialog('Status', 'Note deleted successfully');
    } else {
      _showAlertDialog('Status', 'Error occured while deleting note ');
    }

  }

  // function to display alert dialog
  void _showAlertDialog (String title, String description) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(description),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }


}
