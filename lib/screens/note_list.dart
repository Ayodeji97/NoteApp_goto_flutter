import 'package:flutter/material.dart';
import 'package:note_app_goto/screens/note_details.dart';
import 'dart:async';
import 'package:note_app_goto/models/note.dart';
import 'package:note_app_goto/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';


class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  // singleton instance of noteList
  DatabaseHelper databaseHelper = DatabaseHelper();
  List <Note> noteList;
  int count = 0;


  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),

      body: getNoteListView(),

      floatingActionButton: FloatingActionButton (
        onPressed: () {
          debugPrint('FAB ClICK');
          navigateToDetailScreen(Note('', '', 3), 'Add Note');
        },

        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView () {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {

        Card (
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),

            title: Text(this.noteList[position].title, style: titleStyle,),
            subtitle: Text(this.noteList[position].date),
            trailing: GestureDetector (
              child:Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
            onTap: () {
              debugPrint('Item clicked');
              navigateToDetailScreen(this.noteList[position], 'Edit Note');
            },
          ),
        );
      }
    );
  }

  // Helper function that helps return the priority color
  Color getPriorityColor (int priority) {
    switch (priority) {
      case 1 :
        return Colors.red;
        break;
      case 2 :
        return Colors.yellow;
        break;
      case 3 : Colors.blue;
        break;

      default :
        return Colors.blue;
    }
  }

  // return the priority icon

  Icon getPriorityIcon (int priority) {
    switch (priority) {
      case 1 :
        return Icon(Icons.play_arrow);
        break;
      case 2 :
        return Icon(Icons.keyboard_arrow_right);
        break;
      case 3 :
        return Icon(Icons.arrow_back_sharp);

      default :
        return Icon(Icons.arrow_back_sharp);
    }

  }

  void _delete (BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackBar (context, 'Note Deleted Successfully');

      // TODO update list view
      updateListView();
    }

  }

  // snack bar
  _showSnackBar (BuildContext context, String message) {
      final snackBar = SnackBar(content: Text(message));
      Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetailScreen (Note note, String title) {
    Navigator.push(context, MaterialPageRoute(builder : (context) {
      return NoteDetail(note, title);
    }));
  }

  void updateListView() {

    final Future <Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      // update the ui
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });

      });

    });
  }

}
