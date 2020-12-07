import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {

  static var _priorities = ['High', 'Normal', 'Low'];
  // used to control what the user enter into the text field

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _priorities[0];
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _minimumPadding = 5.0;

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
                value: _currentItemSelected,
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('User Selected $valueSelectedByUser');
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
                  debugPrint('Something something I love doing...');
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
                      },
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
