import 'package:flutter/material.dart';
import 'package:note_app_goto/screens/note_details.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),

      body: getNoteListView(),

      floatingActionButton: FloatingActionButton (
        onPressed: () {
          debugPrint('FAB ClICK');
          navigateToDetailScreen('Add Note');
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
              backgroundColor: Colors.deepOrange,
              child: Icon(Icons.keyboard_arrow_right),
            ),

            title: Text('Dummy title', style: titleStyle,),
            subtitle: Text('Dummy date'),
            trailing: Icon(Icons.delete, color: Colors.grey,),

            onTap: () {
              debugPrint('Item clicked');
              navigateToDetailScreen('Edit Note');
            },
          ),
        );
      }
    );
  }

  void navigateToDetailScreen (String title) {
    Navigator.push(context, MaterialPageRoute(builder : (context) {
      return NoteDetail(title);
    }));
  }
}
