import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {

  static var _priorities = ['High', 'Normal', 'Low'];
  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
                value: 'low',
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('User Selected $valueSelectedByUser');
                  });
                },
              ),
            )
          ],
        ),
      ),

    );
  }
}
